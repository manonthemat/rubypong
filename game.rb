#!/usr/bin/env ruby -w

require 'gosu'
require './lib/ball'
require './lib/player'


class Pong < Gosu::Window

	WIDTH = 768
	HEIGHT = 576

	def initialize
		super(WIDTH, HEIGHT, false)
		@ball = Ball.new
		@font = Gosu::Font.new(self, "assets/victor-pixel.ttf", 40)

		@left_score = 0
		@right_score = 0

		@left_player = Player.new(:left)
		@right_player = Player.new(:right)
	end

	def draw
		@ball.draw(self)
		@left_player.draw(self)
		@right_player.draw(self)

		@font.draw(@left_score, 30, 15, 0, 1, 1, Gosu::Color::rgb(48,242,128))
		@font.draw(@right_score, WIDTH-53, 15, 0, 1, 1, Gosu::Color::rgb(48,242,128))
	end

	def update
		@ball.move!
		if @ball.off_left?
			@right_score += 1
			@ball = Ball.new
		end
		if @ball.off_right?
			@left_score += 1
			@ball = Ball.new
		end
	end

end

window = Pong.new
window.show