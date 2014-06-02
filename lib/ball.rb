class Ball

	SIZE = 16

	attr_accessor :x, :y, :angle, :speed

	def initialize
		@x = Pong::WIDTH/2
		@y = Pong::HEIGHT/2
		@angle = rand(120) + 30
		@angle *= -1  if rand > 0.5  
		@speed = 6
	end

	def dx
		Gosu.offset_x(angle, speed) 
	end
	
	def dy 
		Gosu.offset_y(angle, speed) 
	end

	def move!
		@x += dx
		@y += dy

		if @y < 0
			@y = 0
			edge_bounce!
		end

		if @y > Pong::HEIGHT
			@y = Pong::HEIGHT
			edge_bounce!
		end
	end

	def edge_bounce!
		@angle = Gosu.angle(0, 0, dx, -dy)	
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

	def off_left?
		x1 < 0
	end

	def off_right?
		x2 > Pong::WIDTH
	end

	def collision?(player)
		x1 < player.x2 &&
		x2 > player.x1 &&
		y1 < player.y2 &&
		y2 > player.y1
	end

	def player_bounce!(player)
		case player.side
		when :left
			@x = player.x2 + SIZE/2
		when :right
			@x = player.x1 - SIZE/2
		end

		ratio = (y - player.y) / Player::HEIGHT
		@angle = ratio * 120 + 90
		@angle *= -1 if player.side == :right
	end
end
