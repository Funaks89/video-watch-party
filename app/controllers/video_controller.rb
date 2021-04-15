class VideoController < ApplicationController
  before_action :set_opentok_vars
  
  def set_opentok_vars
    @api_key = ENV['OPENTOK_API_KEY']
    @api_secret = ENV['OPENTOK_API_SECRET']
    @session_id = Session.create_or_load_session_id
    @token = Session.create_token(@name, @moderator, @session_id)
    @moderator_name = ENV['MODERATOR_NAME']
    @name ||= params[:name]
  end

  def home
  end

  def party
  end

  def screenshare
    @darkmode = 'dark'
  end

  def login
    @name = user_params[:name]
    if user_params[:password] == ENV['PARTY_PASSWORD']
      # raise
      redirect_to party_path(name: @name)
    else
      redirect_to('/', flash: { error: 'Incorrect password' })
    end
  end

  def chat
  end

  private

  def user_params
    params.permit(:name, :password, :authenticity_token, :commit)
  end
end
