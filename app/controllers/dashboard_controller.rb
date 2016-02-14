class DashboardController < ApplicationController
  def index
    @show_topbar = true


   #users pie chart
   # this should be made in only 1 query :(
    normal_users = User.where(:admin => false).count + User.where(:admin => nil).count

    admin_users = User.where(:admin => true).count

    @users = {"Normal users" => normal_users,
              "Admin users" => admin_users }


   #end users pie chart



   #pool active awards
   @pool_active_awards = Bet.where(:nominee_id => Nominee.where(:category_id => Category.where(:award_id => Award.where(:active => true).pluck(:id) ).pluck(:id)).pluck(:id)).sum(:amount).round(2)

   #pool inactive awards
   @pool_inactive_awards = Bet.where(:nominee_id => Nominee.where(:category_id => Category.where(:award_id => Award.where(:active => false).pluck(:id) ).pluck(:id)).pluck(:id)).sum(:amount).round(2)




   @pools_per_awards = Array.new

   awards = Award.all

   awards.each do |award|
     pool_award = Bet.where(:nominee_id => Nominee.where(:category_id => Category.where(:award_id => award.id ).pluck(:id)).pluck(:id)).sum(:amount).round(2)
     @pools_per_awards.push(PoolPerAward.new(award.name,pool_award))
   end

   logger.debug "@pool_per_awards count: #{@pools_per_awards.count}"



  end




    class PoolPerAward
      attr_accessor :award_name, :pool

      def initialize(award_name, pool)
        @award_name = award_name
        @pool = pool
      end

    end




end
