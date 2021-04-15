require 'opentok'

class Session < ApplicationRecord
  # api_key = '47186494'
  # api_secret = '4cb875bc59cb6a18df44862b79ff3cfa3d7270db'
  @opentok = OpenTok::OpenTok.new ENV['OPENTOK_API_KEY'], ENV['OPENTOK_API_KEY_SECRET']
  
  # We want to do 2 things:
  def self.create_new_session
    session = @opentok.create_session :media_mode => :routed
    record = Session.new
    record.session_id = session.session_id
    record.save
    @session_id = session.session_id
    @session_id
  end
  # create a session or connect to one if it exists
  def self.create_or_load_session_id
    if Session.any?
      last_session = Session.last
      if last_session && last_session.expired == false
        @session_id = last_session.session_id
        @session_id
      elsif (last_session && last_session.expired == true) || !last_session
        session_id = create_new_session
      else
        raise 'Something went wrong with the session try again!'
      end
    else
      @session_id = create_new_session
    end
  end
  # Create a token for session and to be able to connect to session
    def self.create_token(username, moderator_name, session_id)
      @token = username == moderator_name ? @opentok.generate_token(session_id, { role: :moderator }) : @opentok.generate_token(session_id)
    end

end
