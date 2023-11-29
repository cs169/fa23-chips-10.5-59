require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'before_action :authenticated' do
    context 'when user is authenticated' do
      before { allow(controller).to receive(:authenticated).and_return(true) }

      it 'does not redirect' do
        #get :index
        #expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not authenticated' do
      before { allow(controller).to receive(:authenticated).and_return(false) }

      it 'redirects to the login page' do
        #get :index
        #expect(response).to redirect_to(login_path)
      end
    end
  end
end
