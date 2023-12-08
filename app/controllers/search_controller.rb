# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    begin
    rescue Google::Apis::CivicinfoV2::Error => api_error
      handle_api_errors(api_error, rep)
    rescue StandardError => error
      Rails.logger.error("Unexpected error for #{rep.name}: #{error.message}")
    end
    render 'representatives/search'
  end

  #handles api errors

  def handle_api_errors(api_error, representative)
    status_code = api_error.status_code
    case status_code
    when 403
      Rails.logger.error("Cannot provide access to following action.")
    when 404
      Rails.logger.error("Representative not found!")
    else #any other errors
      Rails.logger.error("API error occured! Status code #{status_code}")
      raise api_error
    end
  end

end
