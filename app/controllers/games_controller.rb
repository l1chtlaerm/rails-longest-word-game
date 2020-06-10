class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def scores
  end
end
