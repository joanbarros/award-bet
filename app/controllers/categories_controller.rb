class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  @@award_id = 0

  def index
    @show_topbar = true
    @award_name = params[:award_name]
    @@award_id = params[:award_id]
    @categories = Category.where(award_id: params[:award_id])
    #@categories = Category.find_each award_id: (params[:award_id]).to_i
    #@categories = Category.all if @categories.nil?



    @nominees = Nominee.where(:category_id => @categories.pluck(:id))


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
    @category = Category.create(category_params.merge!(award_id: @@award_id))
    respond_to do |format|
      if @category.save
        format.json { head :no_content }
        format.js
        format.html
      else
        format.json { render json: @category.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update(category_params.merge!(award_id: @@award_id))
        format.json { head :no_content }
        format.js { render layout: false }
      else
        format.json { render json: @category.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.js { render layout: false }
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :id, :award_id)
  end
end
