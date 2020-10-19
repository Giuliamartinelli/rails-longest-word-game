require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:word].upcase
    @grid = params[:letters].split
    if @guess.chars.all? { |letter| @guess.count(letter) <= @grid.count(letter)}
      url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
      word_dictonary = open(url).read
      dictionary = JSON.parse(word_dictonary)
      if dictionary["found"] == true
        @result = "Congratulations! #{@guess} is a valid English word!"
      else
        @result = "Sorry but #{@guess} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but the #{@guess} can't be built out of #{params[:letters].gsub(" ", ", ")}"
    end
  end
end

