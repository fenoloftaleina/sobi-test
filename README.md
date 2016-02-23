Sobi-test
=========

Setup
-----

1. Install the rails app: `bundle install && bundle exec rake db:migrate`.
2. Prepare your config: `cp config/application.yml.example config/application.yml` (change whatever you need, but you should be golden by simply copying the example config).
3. Start redis in the background: `redis-server&`.
4. Subscribe to redis: `bundle exec rake server:listen`.
5. Run rails server: `rails s`.
6. Publish a messages from a client whenever you want: `./client.rb 123`.
7. See the live changes on the `/dashboard`.

Package size
------------

The size of one package sent from client to server is: `floor(log10(max_bike_id) + 1) + 1 + 690` plus the overhead of protocols headers and redis itself (e.g. a name of the channel).

Assuming that a package weighs `1024B` at worst and we have 8MB per month, a client can send `8 * 1024 = 8192` messages per month, which makes it almost `265` a day.

Integration test
----------------

Take a look at `spec/features/pubsub_and_live_feed_spec.rb`.
