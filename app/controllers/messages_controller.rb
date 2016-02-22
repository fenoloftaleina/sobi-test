class MessagesController < ApplicationController
  def index
    render json: MessagesSerializer.new(
      MessagesFetcher.new(params[:last_message_id])
    ).call, status: 200
  end
end
