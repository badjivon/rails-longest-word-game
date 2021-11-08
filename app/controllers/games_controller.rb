require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dico = URI.open(url).read
    words = JSON.parse(dico)

    @resultat = {}

    if @word.upcase.chars.all? { |char| @word.upcase.count(char) <= @letters.count(char) }
      if words["found"]
        @resultat[:message] = "Well done!"
      else
        @resultat[:message] = "#{@word} is not an english word"
      end
    else
      @resultat[:message] = "#{@word} is not in the grid"
    end
  end

end
