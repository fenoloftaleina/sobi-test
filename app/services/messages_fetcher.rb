class MessagesFetcher < Struct.new(:last_message_id)
  RECENT_MESSAGES_AMOUNT = 30

  def call
    if last_message_id.blank?
      recent_messages
    else
      newer_messages
    end
  end

  private
  def recent_messages
    Message.last(RECENT_MESSAGES_AMOUNT)
  end

  def newer_messages
    Message.where('id > ?', last_message_id)
  end
end
