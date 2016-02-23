require 'rails_helper'
require 'capybara/rspec'

describe 'pubsub and live feed', js: true do
  it 'shows new message published by client' do
    bike_id = 12345
    Message.destroy_all

    pids = setup_server

    visit '/dashboard'

    send_message_from_client(bike_id)
    sleep(5)

    expect(page).to have_content(bike_id)

    kill_servers(pids)
  end
end

def setup_server
  pids = [spawn("redis-server --port #{ENV['redis_port']}")]
  pids.unshift(spawn("RAILS_ENV=test bundle exec rake server:listen"))

  pids
end

def send_message_from_client(bike_id)
  `./client.rb #{bike_id} #{ENV['redis_port']}`
end

def kill_servers(pids)
  pids.each { |pid| `kill #{pid}` }
end
