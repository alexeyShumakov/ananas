require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation' do
    it 'valid model' do
      category = build :invalid_category
      expect(category).to be_invalid
    end
  end
end
