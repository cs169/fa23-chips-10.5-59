# frozen_string_literal: true
require 'news-api'
require 'httparty'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def search_top_five 
    p "ARTICLEEE:  #{params}"
    api_key = Rails.application.credentials[:NEWS_API_KEY]
    news_api = News.new(api_key)  #In credentials
    #using everything endpoint cause ed post said other end point is unreliable
    #q => keywords/phrases to search URL CODED

   
    @issue = news_item_params[:issue]
    @selected_rep = news_item_params[:representative_id]
    response = HTTParty.get("https://newsapi.org/v2/everything",
      query: { q: "#{@issue} #{@selected_rep}",
        language: 'en', sortBy: 'popularity', pageSize: 5, page: 1 }, 
        headers: {'Authorization' => "Bearer #{api_key}"})
    data = JSON.parse(response.body)
    @top_five = data['articles']
  end


  def create_article_from_api
    p "ARTICLEEE:     "
    sel_article = params[:selected_article]
    parsed = eval(sel_article)
    @news_item = NewsItem.new(title: parsed['title'], description: parsed['description'],
     link: parsed['url'], representative_id: '4', issue: params[:selected_issue])
    @news_item.save
  end

  private

  def set_representative
    @representative = Representative.find(params[:representative_id])

  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_issues_list
    @issues_list = ["Free Speech", "Immigration", "Terrorism", "Social Security and Medicare", "Abortion",
    "Student Loans", "Gun Control", "Unemployment", "Climate Change", "Homelessness", "Racism", "Tax Reform",
    "Net Neutrality", "Religious Freedom", "Border Security", "Minimum Wage", "Equal Pay"]
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
