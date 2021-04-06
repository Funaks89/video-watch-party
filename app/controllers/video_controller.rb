class VideoController < ApplicationController
  def home
  end

  def party
  end

  def screenshare
  end

  def login
    @name = params[:name]
    if params[:password] == ENV['PARTY_PASSWORD']
      redirect_to login_path(name: @name)
    else
      redirect_to('/', flash: { error: 'Incorrect password' })
    end
  end

  def chat
  end

  private

  def params
    params.permit(:name, :password, :authenticity_token, :commit)
  end
end
