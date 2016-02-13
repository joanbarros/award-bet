class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  @@award_id = 0
  @@category_id = 0

  @@updating_nominee = false
  @@nominee = nil

  @@nominee_id = 0

  def index
    @show_topbar = true
    @award_name = params[:award_name]
    @@award_id = params[:award_id]
    @categories = Category.where(award_id: params[:award_id])
    # @categories = Category.find_each award_id: (params[:award_id]).to_i
    # @categories = Category.all if @categories.nil?

    #@nominees = Nominee.where(category_id: @categories.pluck(:id)).joins('LEFT OUTER JOIN bets ON bets.nominee_id = nominees.id and bets.user_id = ' + current_user.id.to_s)



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

  # just for nominees
  def new_nominee
    @@updating_nominee = false
    @nominee = Nominee.new

    @@category_id = params[:category_id]
  end

  def create_nominee
    @@updating_nominee = false
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

  def edit_nominee
    @nominee = Nominee.find_by(id: params[:nominee_id])
  #    @@nominee = Nominee.find_by(id: params[:nominee_id])

  end

  def update_nominee

    respond_to do |format|



      @nominee = Nominee.find_by(id: params[:id])


      #nominee_attributes = Hash['id', params[:nominee_id],'name', params[:nominee_name],'description', params[:nominee_description],'image_url', params[:nominee_image_url]]nominee_attributes

      if @nominee.update(nominee_params.merge!(id: params[:id]))
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @nominee.errors.full_messages, status: :unprocessable_entity }
      end
    end

  end

  def delete_nominee
  end

  def destroy_nominee
    # @nominee.destroy
    @nominee = Nominee.find_by(id: params[:nominee_id])
    Nominee.find_by(id: params[:nominee_id]).destroy
    respond_to do |format|
      format.js { render layout: false }
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def show_nominee
  end

  def set_nominee
    @nominee = Nominee.find(params[:id])
  end

  def nominee_params
      params.require(:nominee).permit(:name, :description, :id, :image_url, :winner)
  end

# end nominees


# bets
 def new_bet
   @bet = Bet.new
   @@nominee_id = params[:nominee_id]
 end


 def create_bet
   @show_topbar = true

   @bet = Bet.create(bet_params.merge!(nominee_id: @@nominee_id).merge!(user_id:current_user.id))

   @nominees_ids_in_category =  Nominee.where(category_id: Nominee.where(id: @@nominee_id ).take.category_id ).pluck(:id)

   @nominees_ids_in_category.delete( @@nominee_id.to_i)


   Bet.where(:nominee_id => @nominees_ids_in_category, :user_id => current_user.id).delete_all

   respond_to do |format|
     if @bet.save
       format.json { head :no_content }
       format.js
       format.html
     else
       format.json { render json: @bet.errors.full_messages, status: :unprocessable_entity }
     end
   end
 end

 def edit_bet

  @bet = Bet.find_by(user_id: current_user.id, nominee_id: params[:nominee_id])


 end

 def update_bet

   respond_to do |format|

     @bet = Bet.find_by(nominee_id: params[:id], user_id:current_user.id)


     if @bet.update(bet_params.merge!(id: params[:id]))
       format.json { head :no_content }
       format.js
     else
       format.json { render json: @bet.errors.full_messages, status: :unprocessable_entity }
     end
   end

 end

 def delete_bet
   @bet = Bet.find_by(nominee_id: params[:id], user_id:current_user.id)
 end

 def destroy_bet
   # @nominee.destroy
  @bet = Bet.find_by(nominee_id: params[:id], user_id:current_user.id)
   Bet.find_by(nominee_id: params[:id], user_id:current_user.id).destroy
   @nominee_id =  params[:id]
   respond_to do |format|
     format.js { render layout: false }
     format.html { redirect_to posts_url }
     format.json { head :no_content }
   end
 end
# end bets


  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :id, :award_id)
  end

 def bet_params
   params.require(:bet).permit(:id, :amount)
 end

end
