require 'rails_helper'

RSpec.describe "CampaignFinances", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/campaign_finances/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/campaign_finances/show"
      expect(response).to have_http_status(:success)
    end
  end

end
