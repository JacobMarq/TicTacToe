module DisplayText
  def enter_name_one
    puts "\nPlayer 1 enter your name: "
  end

  def choose_char
    puts "\nChoose your character 'X' or 'O': "
  end

  def char_error
    puts "\nERROR: please enter 'x' or 'y' "
  end

  def enter_name_two
    puts "\nPlayer 2 enter your name: "
  end

  def make_selection(player)
    puts "#{player} enter a selection from the numbers available: "
  end

  def error_taken
    puts "ERROR: Selection is taken!\n"
  end

  def error_invalid_sel
    puts "ERROR: Selection must be from the numbers displayed!\n"
  end

  def make_new_sel
    puts "Make a new selection: "
  end

  def winner_winner(player)
    puts "#{player.capitalize} Wins!\n"
  end

  def play_again_text
    puts "\nWould you like to play again? \nEnter 'yes' or 'no': "
  end

  def error_invalid_answer
    puts "ERROR: Invalid answer \nplease enter 'yes' or 'no': "
  end

  def thank_you
    puts "\nThank you for playing (:"
  end
end