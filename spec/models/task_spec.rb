require 'rails_helper'

describe Task do

  before :each do
    @task1 = Task.create(description: '')
    @task2 = Task.create(description: 'wtvr')
  end

  it 'validates description attribute' do
    expect(@task1.errors[:description].present?).to eq(true)
    expect(@task2.errors[:description].present?).to eq(false)
  end

end
