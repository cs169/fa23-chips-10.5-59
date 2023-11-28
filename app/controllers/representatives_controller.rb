# frozen_string_literal: true
require 'google/apis/civicinfo_v2'

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all

    #assign new info to reps, 
    @representatives.each do |rep|

      #using logic from serach controller to make api requests
      service = Google::Apis::CivicinfoV2::CivicInfoService.new
      service.key = Rails.application.credentials[:GOOGLE_API_KEY]
      rep_info = service.representative_info_by_address(address: params[:address])

      ### get info from representativeInfoByAddress from the officials section
      rep.address = rep_info.officials['address']
      rep.political_party = rep_info.officials['party']
      rep.photo = rep_info.officials['photoUrl']
      rep.save

      ##handling api errors##
      rescue Google::Apis::CivicinfoV2::Error => api_error
        handle_api_errors(api_error, rep)
      #other errors
      rescue StandardError => error
        Rails.logger.error("Unexpected error for #{rep.name}: #{error.message}")
      end
    end
  end

  def handle_api_errors(api_error, representative)
    status_code = api_error.status_code
    case status_code
    when 403
      Rails.logger.error("Cannot provide access to following action.")
    when 404
      Rails.logger.error("Representative not found!")
    else #any other errors
      Rails.logger.error("API error occured! Status code #{status_code}")
    end
  end
end
