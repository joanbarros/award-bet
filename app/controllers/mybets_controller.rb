class MybetsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @show_topbar = true

    @awards_list = Award.all.pluck(:id, :name)



    @mybets = Category.where(award_id: 1)
  end

  def refresh
  end
end
