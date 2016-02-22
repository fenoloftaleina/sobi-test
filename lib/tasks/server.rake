namespace :server do
  desc "Subscribes to redis and listens to messages from bikes"
  task listen: :environment do
    CHANNEL_NAME = 'sobi-test'

    redis = Redis.new(:timeout => 0)

    redis.subscribe(CHANNEL_NAME) do |on|
      on.message do |_, raw_message|
        MessagesGatherer.new(raw_message).call
      end
    end
  end
end
