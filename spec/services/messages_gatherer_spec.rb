require 'rails_helper'

describe MessagesGatherer do
  describe '#call' do
    let(:raw_message) { "#{bike_id},#{message}" }
    let(:bike_id) { '123' }
    let(:message) { 'a' * 690 }

    it 'stores a new message' do
      expect { MessagesGatherer.new(raw_message).call }.
        to change { Message.count }.by(1)
    end

    it 'stores correct data' do
      MessagesGatherer.new(raw_message).call

      expect(Message.last).to have_attributes(
        bike_id: bike_id.to_i, text: message
      )
    end
  end
end
