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
       get :new
       expect(response).to render_template(:new)
       expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    describe 'on success' do
      it 'assigns a new user with valid parameters' do
        expect {
          post :create, user: {first_name: "Tom", last_name: "Hanks", email: "Wilson@waters.com", password: "password"}
        }.to change{User.all.count}.by(1)
      end
    end
  end
end
