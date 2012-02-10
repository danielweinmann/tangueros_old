#coding: utf-8

require 'spec_helper'

describe Event do

  context "#get_facebook_data" do
    before do
      class FakeResponse
        def body
          {
            "name" => "Event name",
            "start_time" => "2012-02-06T20:00:00",
            "end_time" => "2012-02-15T22:00:00",
            "location" => "Event location"
          }.to_json
        end
        def headers
          { "location" => "http://picture.url" }
        end
      end
      HTTParty.stub(:get).and_return(FakeResponse.new)
    end
    subject { Event.make! }
    its(:name) { should == "Event name" }
    its(:start_time) { should == "2012-02-06T20:00:00" }
    its(:end_time) { should == "2012-02-15T22:00:00" }
    its(:location) { should == "Event location" }
    its(:picture) { should == "http://picture.url" }
  end
  
end
