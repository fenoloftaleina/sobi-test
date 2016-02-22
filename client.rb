#!/usr/bin/env ruby

require 'rubygems'
require 'redis'

CHANNEL_NAME = 'sobi-test'

def random_690_string
  ((('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a) * 12)[0...690].
    shuffle.join
end

def publish_message(bike_id)
  redis = Redis.new
  redis.publish CHANNEL_NAME, "#{bike_id},#{random_690_string}"
end

def main
  if ARGV.length != 1
    puts "Usage: #{$0} bike_id"
    return
  end

  publish_message(ARGV[0])
end

main
