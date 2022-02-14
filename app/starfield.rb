class Starfield
  def initialize
    @stars = []
    for s in 0..128
      @stars << newstar
    end
  end

  def newstar
    x = rand(1280)
    y = rand(720)
    sh = rand(12) + 4
    r = rand(360)
    c = rand(15)
    mc = c
    [x, y, sh, r, c, mc]
  end

  def calcstar s
    x = s[0]
    y = s[1]
    sh = s[2]
    r = s[3]
    c = s[4] - 1
    mc = s[5]
    if c <= 0
      x -= 1
      c = mc
    end
    if x < 0
      x = rand(4) + 1276
      y = rand(720)
      sh = rand(12) + 4
      r = rand(360)
      c = rand(15)
      mc = c
    end
    [x, y, sh, r, c, mc]
  end

  def tick
    arr = []
    @stars.each { |s|
      arr << calcstar(s)
    }
    @stars = arr
  end

  def render
    arr = []
    arr << [0, 0, 1280, 720, 0, 0, 0].solids
    @stars.each { |s|
      x = s[0]
      y = s[1]
      sh = s[2]
      r = s[3]
      arr << [x, y, sh, sh, 'sprites/star.png', r].sprites
    }
    arr
  end
end