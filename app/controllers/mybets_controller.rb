class MybetsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @show_topbar = true


  @awards_list = Award.all.pluck(:id, :name)

if params[:award].nil?
  @selection_id = @awards_list[0][0]
else
  @selection_id = params[:award]
end

    #@mybets = Category.where(award_id: @awards_list[0][0])

    #bets = Award.joins(:categories, :nominees).joins('JOIN bets ON bets.nominee_id = nominees.id').where(:id => @awards_list[0][0])


   #@bets = Array.new
   #@total_share = 0.00
   #@award_active = true
   #@award_active  = nil



  @bets, @total_share, @award_active = calculate_bets(@awards_list[0][0])


  end

  def refresh
    @show_topbar = true
    @selection_id = params[:id]
    @bets, @total_share, @award_active = calculate_bets(params[:award])
    render "index"
  end



  def calculate_bets(award)





    @bets = Array.new
    @total_share = 0.00
    @award_active = true
    @award_active  = nil

    awards = Award.includes(:categories).where(:categories => {:award_id => award }).includes(:nominees).all

    @award_active = awards[0].active

    awards.each do |award|
       award.categories.each do |category|
         category.nominees.each do |nominee|


           bet_amount = Bet.where('nominee_id = ? AND user_id = ?', nominee.id, current_user.id).take
           other_bets_amount = Bet.where('nominee_id = ? AND user_id <> ?', nominee.id, current_user.id).sum(:amount)

           logger.debug "bet_amount: #{bet_amount.to_s}"
           logger.debug "other_bets_amount: #{other_bets_amount.to_s}"

          if !bet_amount.nil?
            bet_amount = bet_amount.amount
            logger.debug "bet_amount2: #{bet_amount.to_s}"
               total_bets_nominee = Bet.where('nominee_id = ?', nominee.id).sum(:amount)
               total_bets_category = Bet.where(:nominee_id => Nominee.where(:category_id => category.id).pluck(:id) ).sum(:amount)

               logger.debug "total_bets_nominee: #{total_bets_nominee.to_s}"
               logger.debug "total_bets_category; #{total_bets_category.to_s}"

                money_share = 0



                nominee_winner = nominee.winner

                logger.debug "nominee_winner: #{nominee_winner}"

               if nominee_winner
                  if (other_bets_amount > 0)
                      money_share =  total_bets_category * (bet_amount / total_bets_nominee)
                    else
                      money_share = total_bets_category * 1
                end

                @total_share += money_share

             end




             @bets.push(MybetForPrint.new(category.name,nominee.name,bet_amount,nominee_winner,money_share, @active_award))
           end



         end
       end
     end

      return @bets, @total_share, @award_active

  end








   class MybetForPrint
     attr_accessor :category_name, :nominee_name, :bet_amount, :nominee_winner, :money_share,:active_award

     def initialize(category_name, nominee_name, bet_amount, nominee_winner, money_share, active_award)
       @category_name = category_name
       @nominee_name = nominee_name
       @bet_amount = bet_amount
       @nominee_winner = nominee_winner
       @money_share = money_share
       @active_award = active_award
     end

   end



end
