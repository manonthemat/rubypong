#!/usr/bin/env ruby -w

require 'gosu'
require './lib/ball'

class Pong < Gosu::Window

	WIDTH = 768
	HEIGHT = 576

	def initialize
		super(WIDTH, HEIGHT, false)
		@ball = Ball.new
		@font = Gosu::Font.new(self, "assets/victor-pixel.ttf", 40)

		@left_score = 0
		@right_score = 0
	end

	def draw
		@ball.draw(self)

		@font.draw(@left_score, 30, 15, 0)
		@font.draw(@right_score, WIDTH-53, 15, 0)
	end

	def update
		@ball.move!
	end

end

window = Pong.new
window.show