require 'rails_helper'

describe 'User' do

  before :each do
    @user1 = User.create(first_name:'', last_name:'', email:'', password:'', password_confirmation:'')
    @user2 = User.create(first_name:'Alex', last_name: nil, email: nil, password: nil, password_confirmation: nil)
    @user3 = User.create(first_name:'Alex', last_name: 'Laudon', email: nil, password: nil, password_confirmation: nil)
    @user4 = User.create(first_name:'Alex', last_name: 'Laudon', email: 'alaudon@gmail.com', password: nil, password_confirmation: nil)
    @user5 = User.create(first_name:'Alex', last_name: 'Laudon', email: 'alaudon@gmail.com', password: 'laudon', password_confirmation: 'laudon')
  end

  it 'validates all User attributes' do
    expect(@user1.errors.size).to eq(4)
    expect(@user2.errors.size).to eq(3)
    expect(@user3.errors.size).to eq(2)
    expect(@user4.errors[:password].present?).to eq(true)
    expect(@user5.errors.size).to eq(0)
  end

end
