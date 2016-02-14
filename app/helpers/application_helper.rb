module ApplicationHelper
  def border_color_nominee(bet, winner)
    border_properties = 'border-style:solid;border-width:2px; '
    border_class = 'border-color:'

    logger.debug "-.>>> bet #{bet}"
    logger.debug "-.>>> winner #{winner}"

    #    if (bet.nil? || bet == 0) && (winner.nil? || winner == false)
    #      border_class = 'nominee_normal'
    #    end

    #    if (!bet.nil? || bet != 0) && (winner == true)
    #      border_class += 'nominee_right_bet'
    #    end

    #    if (!bet.nil? || bet != 0) && (winner.nil? || winner == false)
    #      border_class += 'nominee_wrong_bet'
    #    end

    # if (bet.nil? || bet == 0) && (winner == true)
    #       border_class += 'nominee_winner'
    #  end

    border_class += if winner
                      '#2483e6'
                    else
                      '#fff'
    end

    logger.debug ">>>>-> border_properties: #{border_properties}"

    border_properties + border_class
    end



  def disabled_betting(nominee_id)
    logger.debug ">@>@>@>@> #{Nominee.where(:id => nominee_id).take.id}"
    logger.debug ">>$<> #{Category.where(id:  Nominee.where(:id => nominee_id).take.category_id  ).take.award_id}"
    category_id =
     (!Award.where(id: Category.where(id:  Nominee.where(:id => nominee_id).take.category_id  ).take.award_id ).take.active) ? 'hide' : ' '
  end


end
