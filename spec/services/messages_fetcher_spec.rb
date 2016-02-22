require 'rails_helper'

describe MessagesFetcher do
  describe '#call' do
    context 'first time frontend call' do
      it 'returns recent messages' do
        message = create_message
        last_message_id = nil

        expect(MessagesFetcher.new(last_message_id).call).to eq([message])
      end
    end

    context 'with last_message_id' do
      it 'returns only messages that were created after the one with said id' do
        first_message = create_message
        second_message = create_message

        expect(MessagesFetcher.new(first_message.id).call).to eq([second_message])
      end
    end
  end
end

def create_message
  Message.create
end
