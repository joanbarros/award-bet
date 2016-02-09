class NomineesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_nominee, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

@@category_id = 0

def index
end


def show
  @show_topbar = true
  @nominee = Nominee.find(params[:id])
end

def new
  @nominee = Nominee.new
  render :nothing => true
end

def create
  @show_topbar = true
  @nominee = Nominee.create(nominee_params.merge!(category_id: @@category_id))
  respond_to do |format|
    if @nominee.save
      format.json { head :no_content }
      format.js
      format.html
    else
      format.json { render json: @nominee.errors.full_messages, status: :unprocessable_entity }
    end
  end
end

def edit
end

def update
  respond_to do |format|
    if @nominee.update(category_params.merge!(category_id: @@award_id))
      format.json { head :no_content }
      format.js { render layout: false }
    else
      format.json { render json: @category.errors.full_messages, status: :unprocessable_entity }
    end
  end
end

def destroy
  @nominee.destroy
  respond_to do |format|
    format.js { render layout: false }
    format.html { redirect_to posts_url }
    format.json { head :no_content }
  end
end

#no resource methods in order to place and unplace bets

def bet
end

def unbet
end


private

def set_nominee
  @nominee = Nominee.find(params[:id])
end

def nominee_params
  params.require(:category).permit(:name, :description, :id)
end



end
