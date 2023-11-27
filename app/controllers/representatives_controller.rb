# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all

  # not sure if this belongs here or the model
    @representatives.each do |rep|
      #fetch_representative_info is part of civic API, ocd_id = rep identifier
      civic = GoogleCivicApi.fetch_representative_info(rep.ocd_id)
      rep.address = civic['address']
      rep.political_party = civic['party']
      rep.photo = civic['photo']
      rep.save
  end
end
