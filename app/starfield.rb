class Star
  attr_accessor :x, :y, :z, :sh, :r, :c, :mc
  def initialize
    @x = rand(1280)
    @y = rand(720)
    @z = rand(128)
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
    [@x, @y, @sh, @sh, 'sprites/star.png', @r].sprites
  end
end

class Starfield
  def initialize
    @stars = []
    0..128.each { @stars << Star.new() }
  end

  def tick
    @stars.each { |s| s.calc() }
  end

  def render
    arr = []
    arr << [0, 0, 1280, 720, 0, 0, 0].solids
    @stars.each { |s|
      arr << s.render()
    }
    arr
  end
end