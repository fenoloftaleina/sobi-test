class MessagesGatherer < Struct.new(:raw_message)
  def call
    store_message
  end

  private
  def store_message
    bike_id, message = parse_message

    Message.create!(bike_id: bike_id, text: message)
  end

  def parse_message
    raw_message.split(',')
  end
end
