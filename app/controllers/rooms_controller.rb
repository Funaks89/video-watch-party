class RoomsController < ApplicationController
  has_many :room_messages, dependent: :destroy, inverse_of: :room    
  def chat
    @rooms = Room.all
  end
end
