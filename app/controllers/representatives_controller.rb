# frozen_string_literal: true
require 'google/apis/civicinfo_v2'

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find_by(id: params[:id])
  end

end