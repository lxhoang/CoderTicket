require 'rails_helper'

RSpec.describe Event, type: :model do
	describe ".upcoming" do
		it "return [] when there is no events" do
  		expect(Event.upcoming).to eq []
  	end
  	
  	it "return [] when there is only past events" do
  		Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
                venue: Venue.new, category: Category.new)
  		expect(Event.upcoming).to eq []
  		

  	end


  	it "return [b] when there is 'a' past event and 'b' as future event" do
  		a = Event.create!(name: "a", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event", venue: Venue.new, category: Category.new)
  		b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " b future event", venue: Venue.new, category: Category.new)
  		expect(Event.upcoming).to eq [b]
  		
  	end


	end
end
