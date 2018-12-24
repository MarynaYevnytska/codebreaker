# frozen_string_literal: true


require_relative './autoload/autoload.rb'
game_new = Console.new
game_new.choice(game_new.question {})
