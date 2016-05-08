require 'rails_helper'

RSpec.describe History, type: :model do
  describe '#as_json' do
    it 'create ams json' do
      history = create :history
      history_json = HistorySerializer.new(history).as_json
      expect(history.as_json).to eq(history_json)
    end
  end
end
