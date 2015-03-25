require 'rails_helper'

describe Membership do
  before :each do
    @project = create_project
    @user = create_user
    @user2 = create_user(email: 'wtvr@bro.net')
    @membership1 = create_membership(@project, @user)
  end

  it 'validates all required validations' do
    @membership2 = Membership.create(project_id: @project.id, role: "Member")
    @membership3 = Membership.create(project_id: @project.id, user_id: @user.id, role: "Owner")
    @membership4 = Membership.create(project_id: @project.id, user_id: @user2.id, role: "Hello World")
    @membership5 = Membership.create(project_id: @project.id, user_id: @user2.id, role: "Member")

    expect(@membership2.errors.messages.first).to eq( [:user_id, ["can't be blank"]] )
    expect(@membership3.errors.messages.first).to eq( [:user_id, ["has already been added to this project"]])
    expect(@membership4.errors.messages.first).to eq( [:role, ["is not included in the list"]] )
    expect(@membership5.errors.present?).to eq(false)

  end

end
