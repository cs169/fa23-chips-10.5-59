require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state) do
      # Assuming is_territory is a boolean column
      State.create(name: 'Example State', symbol: 'example_state', fips_code: 123, is_territory: false)
    end
    let(:state_symbol) { state.symbol }

    it 'returns JSON with state counties' do
      get :counties, params: { state_symbol: state_symbol }, format: :json
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed).to eq(state.counties.as_json)
    end

    context 'when state is not found' do
      it 'returns response with error' do
        get :counties, params: { state_symbol: 'nonexistent_state' }, format: :json
        expect(response).to have_http_status(:not_found)
        parsed = JSON.parse(response.body)
        expect(parsed).to eq({ 'error' => 'State not found' })
      end
    end
  end
end