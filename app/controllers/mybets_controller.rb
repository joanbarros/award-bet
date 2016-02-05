class MybetsController < ApplicationController

before_filter :authenticate_user!

  def index
    @show_topbar = true
  end
end
