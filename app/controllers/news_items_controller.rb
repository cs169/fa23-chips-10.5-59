# frozen_string_literal: true

class NewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_news_item, only: %i[show]

  def index
    @news_items = @representative.news_items
  end

  def show; end

  private

  def set_representative
    @representative = Representative.find_by(id: params[:representative_id])
    unless @representative
      # Handle the case when the representative with the given ID is not found
      render status: :not_found, json: { error: 'Representative not found' }
    end
  end

  
  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end
end
