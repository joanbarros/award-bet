class CategoryController < ApplicationController
  def index
        @show_topbar = true
        @categories = Category.all
        @award_name = params[:award_name]
  end

  def show
  end
end
