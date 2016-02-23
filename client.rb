#!/usr/bin/env ruby

require 'rubygems'
require 'redis'

CHANNEL_NAME = 'sobi-test'

def random_690_string
  ((('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a) * 12)[0...690].
    shuffle.join
end

def publish_message(bike_id, redis_port = nil)
  redis = Redis.new(port: redis_port || 6379)
  redis.publish CHANNEL_NAME, "#{bike_id},#{random_690_string}"
end

def main(args)
  if !(args.length >= 1 && args.length <= 2)
    puts "Usage: #{$0} bike_id [redis_port]"
    return -1
  end

  publish_message(args[0], args[1])
  return 0
end

if __FILE__ == $0
  main(ARGV)
end
