require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = User.new(name:'hoang', email: "testing@gmail.com", password: '123456', password_confirmation: "123456")
	end

  it "should be valid" do
  	expect(@user.valid?).to be true
	end

	

end


