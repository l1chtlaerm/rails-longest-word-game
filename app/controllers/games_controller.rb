class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def create
    # Save the user ID in the session so it can be used in
    # subsequent requests
    session[:current_user_id] = user.id
    session[:score] = 0
  end

  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = JSON.parse(params[:letters])
    @english_word = english_word?(params[:answer])
    @word_grid = word_grid?(params[:answer].upcase, @letters)
    @result = result_constructor
    @score = @word_grid && @english_word ? params[:answer].length : 0
  end

  def result_constructor
    if @word_grid
      if @english_word
        "Congratulations! #{params[:answer]} is a valid English Word!"
      else
        "Sorry but #{params[:answer]} is not a valid English word..."
      end
    else
      "Sorry but #{params[:answer]} can't be built out of #{@letters.join(', ')}"
    end
  end

  def word_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
