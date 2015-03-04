require 'rails_helper'

describe 'User' do

  before :each do
    @user1 = User.create(first_name:'', last_name:'', email:'')
    @user2 = User.create(first_name:'Alex', last_name: nil, email: nil)
    @user3 = User.create(first_name:'Alex', last_name: 'Laudon', email: nil)
    @user4 = User.create(first_name:'Alex', last_name: 'Laudon', email: 'alaudon@gmail.com')
  end

  it 'validates all User attributes' do
    expect(@user1.errors.size).to eq(3)
    expect(@user2.errors.size).to eq(2)
    expect(@user3.errors[:email].present?).to eq(true)
    expect(@user4.errors.size).to eq(0)
  end

end
