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



   




  end
end
