class AwardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_award, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @show_topbar = true
    @awards = Award.all
  end

  def show
    @show_topbar = true
    @award = Award.find(params[:id])
  end

  def new
    @award = Award.new
 end

  def create
    @show_topbar = true
    @award = Award.create(award_params)
    respond_to do |format|
      if @award.save
        format.json { head :no_content }
        format.js
        format.html
      else
        format.json { render json: @award.errors.full_messages, status: :unprocessable_entity }
      end
    end
   end

  def edit
  end

  def update
    respond_to do |format|
      if @award.update(award_params)
        format.json { head :no_content }
        format.js { render layout: false }
      else
        format.json { render json: @award.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @award.destroy
    respond_to do |format|
      format.js { render layout: false }
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private

  def set_award
    @award = Award.find(params[:id])
  end

  def award_params
    params.require(:award).permit(:name, :description, :closing_date, :active)
  end
end
