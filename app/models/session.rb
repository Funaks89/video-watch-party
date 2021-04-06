require 'opentok'

class Session < ApplicationRecord
  @opentok = Opentok::OpenTok.new ENV['OPENTOK_API_KEY'], ENV['OPTOK_API_SECRET']

  # We want to do 2 things:
  def self.create_new_session
    session = @opentok.create_session
    record = Session.new
    record.session_id = session.session_id
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
  # Create a token for session and to be able to connect to session
    def self.create_token(username, moderator_name, session_id)
      @token = username == moderator_name ? @opentok.generate_token(session_id, { role: :moderator }) : @opentok.generate_token(session_id)
    end
end
