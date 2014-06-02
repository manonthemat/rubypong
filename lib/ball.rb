class Ball

	SIZE = 8

	attr_accessor :x, :y

	def initialize
		@x = Pong::WIDTH/2
		@y = Pong::HEIGHT/2
	end

	def x1; @x - SIZE/2; end
	def x2; @x + SIZE/2; end
	def y1; @y - SIZE/2; end
	def y2; @y + SIZE/2; end

	def draw(window)
		color = Gosu::Color::rgb(48, 162, 242)
		window.draw_quad(
			x1, y1, color,
			x1, y2, color,
			x2, y2, color,
			x2, y1, color
			)
	end
end
