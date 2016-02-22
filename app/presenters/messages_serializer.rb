class MessagesSerializer < Struct.new(:messages_fetcher)
  def call
    {
      last_message_id: last_message_id,
      messages: serialized_messages
    }
  end

  private
  def messages
    @messages ||= messages_fetcher.call.to_a
  end

  def last_message_id
    messages.last.try(:id) || messages_fetcher.last_message_id
  end

  def serialized_messages
    messages.map do |message|
      {
        bike_id: message.bike_id,
        text: message.text
      }
    end
  end
end
