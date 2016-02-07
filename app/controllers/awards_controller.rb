class AwardsController < ApplicationController

  before_filter :authenticate_user!
  before_action :all_awards, only: [:index, :create, :destroy, :update]
  respond_to :html, :js


  def index
    @show_topbar = true
    @award = Award.new
    @awards = Award.all
  end


def new
  @awards = Award.new
end


def all_awards
  @awards = Award.all
end

def award_params
  params.require(:award).permit(:id, :name, :description, :closing_date, :active)
end

 def create
   @show_topbar = true
  #@awards = Award.all
   @award = Award.create(award_params)
   render "awards/index"
 end


def edit
  @award = Award.find(params[:id])
end

def update
  @awards = Award.all
  @award = Award.find(params[:id])
  @award.update_attributes(award_params)
end

def delete
  @award = Award.find(params[:award_id])
    @award.destroy
end

def destroy
  @award = Award.find(params[:id])
  @award.destroy
  @awards = Award.all
end


end
