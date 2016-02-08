class CategoriesController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js




  def index
        @show_topbar = true
        @award_name = params[:award_name]
        @categories = Category.find_by award_id: params[:award_id]
        if @categories == nil
          @categories = Category.all
        end
  end

  def show
      @show_topbar = true
      @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
   @show_topbar = true
   @category = Category.create(category_params)
   respond_to do |format|
     if @category.save
       format.json { head :no_content }
       format.js
       format.html
     else
       format.json {render json: @category.errors.full_messages, status: :unprocessable_entity}
     end
   end
  end


  def edit
  end


  def update
   respond_to do |format|
     if @category.update(category_params)
       format.json {head :no_content}
       format.js {render layout: false}
     else
       format.json {render json: @category.errors.full_messages, status: :unprocessable_entity}
     end
   end
  end



  def destroy
   @category.destroy
   respond_to do |format|
     format.js {render layout: false}
     format.html {redirect_to posts_url}
     format.json {head :no_content}
   end
  end

  private

  def set_category
  @category = category.find(params[:id])
  end

  def category_params
  params.require(:category).permit(:name, :description)
  end





end
