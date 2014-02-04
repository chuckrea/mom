require "api.rb"

class WelcomeController < ApplicationController
  include Api

  def index

  end

  def create

    account_sid = 'AC2e3cd4670d5a455fb0e6da2e5ddd5eeb'
    auth_token = 'b40b07ba1a2d3d92bb5e9e2c77330c3b'
    responses = ["It's Mom! I just sent you the funniest chain email.  Check it out!", "Mom here. Do you still need your old dance costumes?", "Hey, it's Mom. I haven't heard from you in forever!"]

    respond_to do |format|
      format.html
      format.json do
      # set up a client to talk to the Twilio REST API
      client = Twilio::REST::Client.new account_sid, auth_token
      client.account.messages.create(
          :from => '+16463623890',
          :to => params[:phone_num],
          :body => responses.sample
        )
      end
    end
    redirect_to root_path
  end




end