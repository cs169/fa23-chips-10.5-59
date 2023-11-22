# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
  end
  
  def index
    @representatives = Representative.all
  end
end
