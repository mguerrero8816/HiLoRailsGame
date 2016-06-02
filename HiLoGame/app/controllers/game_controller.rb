class GameController < ApplicationController

  def user_decision
    if params[:decision] == 'reset'
      reset
    else
      try
    end
  end

  def reset
    reset_counter
    generate_new_answer
    render 'try.html.erb'
  end

  def try
    # if the cookie with the answer is empty
    if cookies[:answer].nil?
      #call the method to generate a new random number
      generate_new_answer
    end
    #store user input to an instance variable
    @user_try = params[:decision].to_i
    get_answer

    #create a counter for the user decisiones
    if cookies[:counter].nil?
      reset_counter
    end

    increment_counter
    if @user_try == @answer
      @result = ': You Win!'
      cookies[:wins] = cookies[:wins].to_i + 1
      reset_counter
      generate_new_answer
      @buttonText = 'Play Again?'
    elsif @user_try > @answer
      @result = 'is too high. Try again'
      @buttonText = 'Guess Lower'
    else
      @result = 'is too low. Try again'
      @buttonText = 'Guess Higher'
    end
    render 'try.html.erb'
  end

  # Purpose: gets a random number as the asnwer to the game
  #Signature: nothing -> nothing
  def generate_new_answer
    #assigns a random number from 1-100 to the cookies[:answer] hashtable
    cookies[:answer] = rand(100) + 1
    #call method to convert string in the hashtable to an integer
    get_answer
  end

  # Purpose: converts string from cookie hashtable to an integer
  # Signature: nothing -> integer
  def get_answer
    #converts the contents of the :answer key to an integer and assins it to an instance variable
    @answer = cookies[:answer].to_i
  end

  def increment_counter
    cookies[:counter] = cookies[:counter].to_i + 1
    @counter = cookies[:counter]
  end

  def reset_counter
    cookies[:counter]=0
    @counter = cookies[:counter]
  end

end
