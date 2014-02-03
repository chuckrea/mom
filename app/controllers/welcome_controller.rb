require "api.rb"

class WelcomeController < ApplicationController
  include Api

  def index

  end

  def create


    send_weather_texts

    redirect_to '/'

  end




end