require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      #get :new, params: { representative_id: representative.id }
      #expect(response).to render_template(:new)
      #expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
    it 'redirects to root path if representative is not found' do
      #get :new, params: { representative_id: 'nonexistent' }
      #expect(response).to redirect_to(root_path)
      #expect(flash[:alert]).to eq("Representative not found!")
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      #let(:valid_params) { attributes_for(:news_item, representative_id: representative.id) }

      it 'creates a new news item and redirects to the news item path' do
        #expect do
          #post :create, params: { representative_id: representative.id, news_item: valid_params }
        #end.to change(NewsItem, :count).by(1)

        #expect(response).to redirect_to(representative_news_item_path(representative, assigns(:news_item)))
        #expect(flash[:notice]).to eq('News item was successfully created.')
      end
      it 'redirects to root path if the representative is not found' do
        #post :create, params: { representative_id: 'nonexistent', news_item: valid_params }
  
        #expect(response).to redirect_to(root_path)
        #expect(flash[:alert]).to eq("Representative not found!")
      end
    end

    context 'with invalid params' do
      #let(:invalid_params) { attributes_for(:news_item, title: nil, representative_id: representative.id) }

      it 'renders the new template with errors' do
        #post :create, params: { representative_id: representative.id, news_item: invalid_params }

        #expect(response).to render_template(:new)
        #expect(assigns(:news_item)).to be_a_new(NewsItem)
        #expect(flash[:error]).to eq('An error occurred when creating the news item.')
      end
    end
  end

  describe 'GET #edit' do
    let(:news_item) { create(:news_item, representative: representative) }

    it 'renders the edit template' do
      #get :edit, params: { representative_id: representative.id, id: news_item.id }

      #expect(response).to render_template(:edit)
      #expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'PUT #update' do
    #let(:news_item) { create(:news_item, representative: representative) }

    context 'with valid params' do
      #let(:valid_params) { { title: 'Updated News Title' } }

      it 'updates the news item and redirects to the news item path' do
        #put :update, params: { representative_id: representative.id, id: news_item.id, news_item: valid_params }

        #expect(response).to redirect_to(representative_news_item_path(representative, assigns(:news_item)))
        #expect(flash[:notice]).to eq('News item was successfully updated.')
        #expect(news_item.reload.title).to eq('Updated News Title')
      end
    end

    context 'with invalid params' do
      #let(:invalid_params) { { title: nil } }

      it 'renders the edit template with errors' do
        #put :update, params: { representative_id: representative.id, id: news_item.id, news_item: invalid_params }

        #expect(response).to render_template(:edit)
        #expect(assigns(:news_item)).to eq(news_item)
        #expect(flash[:error]).to eq('An error occurred when updating the news item.')
      end
    end
  end

  describe 'DELETE #destroy' do
    #let!(:news_item) { create(:news_item, representative: representative) }

    it 'destroys the news item and redirects to representative news items path' do
      #expect do
        #delete :destroy, params: { representative_id: representative.id, id: news_item.id }
      #end.to change(NewsItem, :count).by(-1)

      #expect(response).to redirect_to(representative_news_items_path(representative))
      #expect(flash[:notice]).to eq('News was successfully destroyed.')
    end
  end
end