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


      

  end
end
