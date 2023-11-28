# frozen_string_literal: true
require 'google/apis/civicinfo_v2'

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  
    @representatives.each do |rep| # assign new info to reps
      begin
        # using logic from search controller to make API requests
        service = Google::Apis::CivicinfoV2::CivicInfoService.new
        service.key = Rails.application.credentials[:GOOGLE_API_KEY]
        rep_info = service.representative_info_by_address(address: params[:address])
  
        if rep_info&.officials&.any? # make sure it's not nil
          # get info from representativeInfoByAddress from the officials section
          curr_rep = rep_info.officials.find { |official| official["name"] == rep.name }
          if curr_rep  # make sure we find it
            rep.address = curr_rep['address']
            rep.political_party = curr_rep['party']
            rep.photo = curr_rep['photoUrl']
            rep.save
          end
        end
      rescue Google::Apis::CivicinfoV2::Error => api_error
        handle_api_errors(api_error, rep)
      rescue StandardError => error
        Rails.logger.error("Unexpected error for #{rep.name}: #{error.message}")
      end
    end
  end

  ##checks for diff api errors
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
