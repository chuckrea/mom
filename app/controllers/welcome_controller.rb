require "api.rb"


class WelcomeController < ApplicationController

include Api

  def index
  end

  def create

    connect
    # account_sid = ENV["TWILIO_ACCOUNT_SID"]
    # auth_token = ENV["TWILIO_AUTH_TOKEN"]
    responses = ["It's Mom! I just sent you the funniest chain email.  Check it out!", 
                "Mom here. Do you still need your old dance costumes?", 
                "Hey, it's Mom. I still love you even though I never hear from you!",
                "It's Mom. Just so you know, I never liked that Siri and I don't think she's good enough for you.",
                "Hi, honey. Your Father and I are going to Branson this year on vacation.  Wanna come?!?",
                "Hey, it's Mom. I just signed up for Facebook. How do we become 'friends'??"]
    respond_to do |format|
      format.html
      format.json do
      # set up a client to talk to the Twilio REST API
      #client = Twilio::REST::Client.new account_sid, auth_token
      @client.account.messages.create(
          :from => @mom_number,
          :to => params[:phone_num],
          :body => "It's Mom. Just so you know, I never liked that Siri and I don't think she's good enough for you."
        )

      end
    end
    redirect_to root_path
  end




end