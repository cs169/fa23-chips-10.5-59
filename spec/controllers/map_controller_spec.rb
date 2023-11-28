require 'rails_helper'

RSpec.describe MapController, type: :controller do
  describe 'private methods' do
    let(:state) { 
      create(:state, symbol: 'CA') 
    }
    let(:county) { 
      create(:county, state: state) 
    }

    describe 'handle_state_not_found' do
      it 'redirects and alerts if state is not found' do
        get :state, params: { state_symbol: 'INVALID' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'INVALID' not found.")
      end
    end

    describe 'handle_county_not_found' do
      it 'redirects with alert if county is not found' do
        get :county, params: { state_symbol: 'CA', std_fips_code: 'INVALID' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("County with code 'INVALID' not found for CA")
      end
    end

    describe 'get_requested_county' do
      it 'returns the requested county' do
        get :county, params: { state_symbol: 'CA', std_fips_code: county.std_fips_code }
        expect(assigns(:county)).to eq(county)
      end
    end
  end
end