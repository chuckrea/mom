require 'spec_helper'

describe RegistrationsController do
	it "should allow a user to sign up" do

	  get :sign_up
	  assert_response(:redirect)
	end
end