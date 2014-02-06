require 'spec_helper'

describe UsersController do 

  it "should allow a user to visit register" do 
    # HTTParty.get("http://localhost:4567")
    get :register
    assert_response(:success)
  end

  it "should allow a user to sign in" do 
    get :sign_in
    assert_response(:success)
  end

  it "should allow a user to sign out" do 
    get :sign_out
    assert_response(:redirect)
  end


end