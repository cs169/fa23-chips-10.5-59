require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all events when no filter applied' do
      event_1 = create(:event)
      event_2 = create(:event)

      get :index

      expect(assigns(:events)).to contain_exactly(event_1, event_2)
    end

    it 'assigns filtered events when filter applied' do
      state = create(:state)
      county = create(:county, state: state)
      event = create(:event, county: county)

      get :index, params: { 'filter-by' => 'state-only', 'state' => state.symbol }

      expect(assigns(:events)).to contain_exactly(event)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event to @event' do
      event = create(:event)

      get :show, params: { id: event.id }

      expect(assigns(:event)).to eq(event)
    end
  end
end