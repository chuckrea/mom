require "api.rb"

class WelcomeController < ApplicationController

include Api

  def index
  end

  def create
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]
    # responses = ["It's Mom! I just sent you the funniest chain email.  Check it out!", 
    #             "Mom here. Do you still need your old dance costumes?", 
    #             "Hey, it's Mom. I still love you even though I never hear from you!",
    #             "Hi, honey. Your Father and I are going to Branson this year on vacation.  Wanna come?!?",
    #             "Hey, it's Mom. I just signed up for Facebook. How do we become 'friends'??"]
    respond_to do |format|
      format.html
      format.json do

      send_confirmation_text(params[:phone_num])

      end
    end
    redirect_to root_path
  end




end