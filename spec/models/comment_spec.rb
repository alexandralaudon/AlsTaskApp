require 'rails_helper'

describe Comment do
  before :each do
    @comment1 = Comment.create(message: nil)
    @comment2 = Comment.create(message: "Let me help you out over here")
    @comment3 = Comment.create(message: "aaaaaaaaaaaaa")
  end

  describe '#comments' do
    it 'returns all associated comments' do
      expect(Comment.all.count).to eq(2)
    end
  end

  describe 'validations' do
    it 'requires that comments have messages' do
      expect(@comment1.errors.messages.count).to eq(1)
      expect(@comment2.errors.present?).to eql(false)
    end
  end

end
