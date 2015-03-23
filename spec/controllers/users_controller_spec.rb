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
        }.to change{User.all.count}.from(1).to(2)

        user = User.last
        expect(user.first_name).to eq "Tom"
        expect(user.email).to eq "Wilson@waters.com"
        expect(flash[:notice]).to eq 'User was successfully created!'
        expect(response).to redirect_to users_path
      end
    end
    describe 'on failure' do
      it 'does not assign a new user with invalid parameters' do
        expect {
          post :create, user: {first_name: "Tom", last_name: nil, email: "Wilson@waters.com", password: "password"}
        }.to_not change{User.all.count}

        expect(assigns(:user)).to be_a(User)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns one specific user Object' do
      user2 = create_user(first_name: "Time", last_name: "Watch", email: "whatever@bro.sef")
      get :show, id: user2.id

      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'specifies a specific instance of User for editing' do
      user2 = create_user(first_name: "Time", last_name: "Watch", email: "whatever@bro.sef")
      session[:user_id] = user2.id

      get :edit, id: user2.id

      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    describe 'on success' do
      it 'updates the specific User object if valid parameters are passed' do
        user2 = create_user(first_name: "Time", last_name: "Watch", email: "whatever@bro.sef")
        expect {
          patch :update, id: user2.id, user: {first_name:"Bag", last_name:"Boy"}
        }.to change{user2.reload.first_name}.from("Time").to("Bag")

        expect(flash[:notice]).to eq 'User was successfully updated!'
        expect(response).to redirect_to users_path
      end
    end
    describe 'on failure' do
      it 'does not update the specific User object if invalid parameters are passed' do
        user2 = create_user(first_name: "Time", last_name: "Watch", email: "whatever@bro.sef")

        expect {
          patch :update, id: user2.id, user: {last_name: nil}
        }.to_not change{user2.reload.last_name}

        expect(user2.last_name).to eq 'Watch'
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a specific user object' do
      user2 = create_user(email: "destroy@me.com", admin: false)
      expect {
        delete :destroy, id: user2.id
      }.to change{User.all.count}.from(2).to(1)

      expect(flash[:notice]).to eq 'User was successfully deleted!'
      expect(response).to redirect_to users_path
    end
  end
end
