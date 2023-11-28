require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'private methods' do
    let(:user_info) { 
      { 'provider' => 'google_oauth2', 
        'uid' => '123', 
        'info' => 
          { 'first_name' => 'Harry', 
            'last_name' => 'Styles', 
            'email' => 'harry@styles.com' 
          } 
      } 
    }

    describe '#create_session' do
      it 'clears destination_url if not set' do
        allow(controller).to receive(:redirect_to)
        session[:destination_after_login] = nil

        controller.send(:create_session, :create_google_user)

        expect(session[:destination_after_login]).to be_nil
      end
    end

    describe '#find_or_create_user' do
      it 'calls create method with create_if_not_exists' do
        allow(User).to receive(:find_by).and_return(nil)
        allow(controller).to receive(:create_google_user).and_return(create(:user))

        controller.send(:find_or_create_user, user_info, :create_google_user)

        expect(controller).to have_received(:create_google_user).with(user_info)
      end
    end

    describe '#create_google_user' do
      it 'handles missing user_info fields' do
        user_info['info'] = nil

        user = controller.send(:create_google_user, user_info)

        expect(user.uid).to eq('123')
        expect(user.provider).to eq('google_oauth2')
        expect(user.first_name).to be_nil
        expect(user.last_name).to be_nil
        expect(user.email).to be_nil
      end
    end

    describe '#create_github_user' do
      it 'handles missing user_info fields' do
        user_info['info'] = nil

        user = controller.send(:create_github_user, user_info)

        expect(user.uid).to eq('123')
        expect(user.provider).to eq('github')
        expect(user.first_name).to eq('Anonymous')
        expect(user.last_name).to eq('User')
        expect(user.email).to be_nil
      end
    end

    describe '#already_logged_in' do
      it 'does not set notice if user is not logged in' do
        allow(controller).to receive(:redirect_to)
        session[:current_user_id] = nil

        controller.send(:already_logged_in)

        expect(flash[:notice]).to be_nil
      end
    end
  end
end