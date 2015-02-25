require 'rails_helper'

describe Project do

  before :each do
    @project1 = Project.create(name: "")
    @project2 = Project.create(name: "number 1")
    @project3 = Project.create(name: "number 2")
  end

  it 'validates the presence of project name' do
    expect(@project1.errors[:name].present?).to eql(true)
    expect(@project2.errors[:name].present?).to eql(false)
  end

end
