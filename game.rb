#!/usr/bin/env ruby -w

require 'gosu'
require './lib/ball'
require './lib/player'


class Pong < Gosu::Window

	WIDTH = 768
	HEIGHT = 576

	def initialize
		# Creating window, setting gamestate and preparing assets
		super(WIDTH, HEIGHT, false)
		@game_in_progress = false
		@ball = Ball.new
		@font = Gosu::Font.new(self, "assets/victor-pixel.ttf", 40)
		@left_score = 0
		@right_score = 0
	# Game Soundtrack
	@soundtrack = [] 
	@soundtrack << Gosu::Song.new("assets/audio/cycles.mp3")
	@song = @soundtrack.first
    @song.play(looping = true)

	# Game Foley
	@hit_sample = Gosu::Sample.new(self, "assets/audio/hit.mp3")
	@miss_sample = Gosu::Sample.new(self, "assets/audio/miss.mp3")

  	# Main titles
  	title_screen		
	end

    def title_screen
	    @left_player = Player.new(:left, true)
		@right_player = Player.new(:right, true)
    end  

    def setup_game(number_of_players)
		if number_of_players == 2
			@left_player = Player.new(:left, false)
			@right_player = Player.new(:right, false)
		end
		if number_of_players == 1
			@left_player = Player.new(:left, true)
			@right_player = Player.new(:right, false)
		end
		@game_in_progress = true
	end


	def draw
		unless @game_in_progress
	    @font.draw("PONG", 100, 100, 50, 3.0, 3.0, Gosu::Color::rgb(48,242,225))
	    @font.draw("press '1' for single player", 150, 250, 50, 1, 1, Gosu::Color::rgb(242,128,48))
	    @font.draw("press '2' for multiplayer", 150, 275, 50, 1, 1, Gosu::Color::rgb(242,128,48))
	    end
		@ball.draw(self)
		@left_player.draw(self)
		@right_player.draw(self)
		@font.draw(@left_score, 30, 15, 0, 1, 1, Gosu::Color::rgb(48,242,128))
		@font.draw(@right_score, WIDTH-53, 15, 0, 1, 1, Gosu::Color::rgb(48,242,128))
	end

	def update

		if button_down? Gosu::Kb1
        	setup_game(1) unless @game_in_progress
        end

        if button_down? Gosu::Kb2
        	setup_game(2) unless @game_in_progress
        end

		@ball.move!

		if @left_player.ai?
			@left_player.ai_move!(@ball)
		else
			if button_down?(Gosu::KbW)
				@left_player.up!
			end

			if button_down?(Gosu::KbS)
				@left_player.down!
			end
		end
        
        if @right_player.ai?
			@right_player.ai_move!(@ball)
		else
			if button_down?(Gosu::KbUp)
			@right_player.up!
			end

			if button_down?(Gosu::KbDown)
			@right_player.down!
			end
		end

		if @ball.collision?(@left_player)
			@hit_sample.play
			@ball.player_bounce!(@left_player)
		end

		if @ball.collision?(@right_player)
			@hit_sample.play
			@ball.player_bounce!(@right_player)
		end

		if @ball.off_left?
			@miss_sample.play
			@right_score += 1
			@ball = Ball.new

		end
		if @ball.off_right?
			@miss_sample.play
			@left_score += 1
			@ball = Ball.new
		end
	end

	def button_down(id)
		close if id == Gosu::KbQ
	end


end

window = Pong.new
window.show