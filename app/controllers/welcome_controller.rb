class WelcomeController < ApplicationController

# put your own credentials here


  def index

  end

  def create

    account_sid = 'ACfb7ac7ffa3b4d03c419ae4d98c32afd6'
    auth_token = '63c3b515f991dd71c83cf9bf47031bca'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    
    @client.account.messages.create(
      :from => '+16463623947',
      :to => params[:phone],
      :body => 'Hey there!'
    )

    redirect_to '/'

  end




end