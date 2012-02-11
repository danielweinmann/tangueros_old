require 'machinist/active_record'

EventType.blueprint do
  name { "Type #{sn}" }
end

Event.blueprint do
  url { "http://www.facebook.com/events/214925355266001/" }
  event_type { EventType.make! }
end
