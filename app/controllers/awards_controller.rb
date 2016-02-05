class AwardsController < ApplicationController

  before_filter :authenticate_user!


  def index
    @show_topbar = true
    #@logued_user = current_user.sent_messages.all
  end
end
