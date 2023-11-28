require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { attributes_for(:event) }

      it 'creates a new event and redirects to events_path' do
        expect do
          post :create, params: { event: valid_params }
        end.to change(Event, :count).by(1)

        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { attributes_for(:event, name: nil) }

      it 'renders new template with errors' do
        post :create, params: { event: invalid_params }

        expect(response).to render_template(:new)
        expect(assigns(:event)).to be_a_new(Event)
        expect(flash[:notice]).to be_nil
      end
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event) }

    it 'renders edit template' do
      get :edit, params: { id: event.id }

      expect(response).to render_template(:edit)
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'PUT #update' do
    let(:event) { create(:event) }

    context 'with valid params' do
      let(:valid_params) { { name: 'Updated Event' } }

      it 'updates the event and redirects to events_path' do
        put :update, params: { id: event.id, event: valid_params }

        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was updated.')
        expect(event.reload.name).to eq('Updated Event')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { name: nil } }

      it 'renders the edit template with errors' do
        put :update, params: { id: event.id, event: invalid_params }

        expect(response).to render_template(:edit)
        expect(assigns(:event)).to eq(event)
        expect(flash[:notice]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create(:event) }

    it 'destroys event and redirects to events_path' do
      expect do
        delete :destroy, params: { id: event.id }
      end.to change(Event, :count).by(-1)

      expect(response).to redirect_to(events_path)
      expect(flash[:notice]).to eq('Event was destroyed.')
    end
  end
end