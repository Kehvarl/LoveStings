class Star
  attr_accessor :x, :y, :z, :sh, :r, :c, :mc
  def initialize vx=0, vy=0
    if vy == 0
      @x = rand(1280)
    else
      if vx < 0
        @x = 1280
      else
        @x = 0
      end
    end

    @y = rand(720)
    @z = rand(127) + 1
    @sh = rand(12) + 4
    @r = rand(360)
    @c = rand(15)
    @mc = c
  end

  def calc
    @c -= 1
    if @c <= 0
      @x -= 1
      @c = @mc
    end
    if @x < 0
      @x = rand(4) + 1276
      @y = rand(720)
      @sh = rand(12) + 4
      @r = rand(360)
      @c = rand(15)
      @mc = @c
    end
  end

  def render
    {x: @x, y: @y, w: @sh, h: @sh, path: 'sprites/star.png', angle: @r}.sprite!
  end
end

class Starfield
  def initialize
    @stars = []
    0..128.each { @stars << Star.new() }
    @vx = -0.1
    @vy = -0.1
  end

  def reverse
    @vx = -@vx
    @vy = -@vy
  end

  def tick
    @stars.each { |s| s.x += (@vx * s.z) }
  end

  def render
    arr = []
    arr << [0, 0, 1280, 720, 0, 0, 0].solids
    stars = 0
    @stars.each do |s|

      if s.x >= 0 and s.x <= 1280
        arr << s.render()
        stars += 1
      end
    end
    if stars < 128
      1..(128 - stars).each do
        @stars << Star.new(@vx, @vy)
      end
    end
    arr
  end
end