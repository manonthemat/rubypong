#!/usr/bin/env ruby -w

require 'gosu'
require './lib/ball'

class Pong < Gosu::Window

	WIDTH = 768
	HEIGHT = 576

	def initialize
		super(WIDTH, HEIGHT, false)
		@ball = Ball.new
	end

	def draw
		@ball.draw(self)
	end
end

window = Pong.new
window.show