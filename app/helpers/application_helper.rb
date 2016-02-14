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


if winner
  border_class +='#2483e6'
else
  border_class +='#fff'
end


       logger.debug ">>>>-> border_properties: #{border_properties}"


    return  border_properties + border_class

    end

end
