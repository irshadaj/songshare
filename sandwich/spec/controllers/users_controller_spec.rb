require "rails_helper"

describe UsersController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!)
    @current_user = FactoryGirl.create(:user)
    allow(controller).to receive(:current_user).and_return(@current_user)
  end

  describe '#show' do
    context 'when viewing the current user' do
      it 'assigns the current user' do
        get :show, id: @current_user.id
        expect(assigns(:user)).to eq @current_user
      end

      it 'renders the view' do
        get :show, id: @current_user.id
        expect(response).to render_template(:show)
      end
    end

    context 'when viewing another user who is visible' do
      let(:other_user) { FactoryGirl.create(:user, :visible) }

      it 'assigns the other user' do
        get :show, id: other_user.id
        expect(assigns(:user)).to eq other_user
      end

      it 'renders the view' do
        get :show, id: other_user.id
        expect(response).to render_template(:show)
      end
    end

    context 'when viewing another user who is not visible' do
      let(:other_user) { FactoryGirl.create(:user) }

      it 'redirects to the home page' do
        get :show, id: other_user.id
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe '#index' do
    it 'lists all the visible users' do
      visible_user = FactoryGirl.create(:user, :visible)
      hidden_user = FactoryGirl.create(:user)
      get :index
      expect(assigns(:users)).to include(visible_user)
    end

    it 'renders the index page' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
