class YelpInfo < ActiveRecord::Base
  attr_accessible :address, :cuisine_type, :restaurant_name, :user_id


Yelp.configure(:yws_id          => '55vsTZcAU8kH_LEQj_oIjA',
               :consumer_key    => 'I7sXrBiqGJXGNmZGMeOiJQ',
               :consumer_secret => 'JdMoZU8iGn6iQlvuP2Mk5-EsPt8',
               :token           => '-_031yEPjKzFSJuzTovFdp0M5RufpYC1',
               :token_secret    => 'USpbVVJmAEWq_m4mykUJbcK4kNc')

request = GeoPoint.new(
             :term => "cream puffs",
             :latitude => 37.788022,
             :longitude => -122.399797)
response = client.search(request)

end
