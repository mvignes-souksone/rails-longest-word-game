require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map { ("A".."Z").to_a[rand(26)] }
  end

  def score
    test_grid = "ok"
    @array_letters = params[:letters].split
    params[:word].upcase.chars.each do |letter|
      if @array_letters.include? letter
        @array_letters.delete_at(@array_letters.index(letter))
      else
        test_grid = "ko"
        break
      end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    answer_api = open(url).read
    @answer = JSON.parse(answer_api)

    if test_grid == "ko"
      @score = "word is not valid, it's not in the grid"
    elsif @answer["found"] == false
      @score = "word is not valid, it's not an English word"
    else
      @score = "ok the word is valid"
    end
  end
end
