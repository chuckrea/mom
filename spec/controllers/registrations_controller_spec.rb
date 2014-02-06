require 'spec_helper'

describe RegistrationsController do
	it "should allow a user to sign up" do

	  get :sign_up
	  assert_response(:redirect)
	end

	it "should allow a user to sign in" do
      get :sign_on
	  assert_response(:redirect)
	end
end