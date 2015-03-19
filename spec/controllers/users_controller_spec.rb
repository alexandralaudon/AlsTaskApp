require 'rails_helper'

describe UsersController do
  before(:each) do
    @user = create_user
    session[:user_id] = @user.id
  end

  describe 'GET #index' do
    it 'assigns all User Objects' do
        get :index
        expect(response).to render_template(:index)
        expect(assigns(:users)).to eq [@user]
    end
  end

  describe 'GET #new' do
    it 'assigns a new user object' do
    end
  end
end
