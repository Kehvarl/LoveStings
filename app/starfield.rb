class Starfield
  def initialize
    @stars = []
    for s in 0..128
      x = rand(1280)
      y = rand(720)
      sh = rand(12) + 4
      r = rand(360)
      c = rand(15)
      mc = c
      @stars << [x, y, sh, r, c, mc]
    end
  end

  def tick
    arr = []
    for s in @stars
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
      arr << [x, y, sh, r, c, mc]
    end
    @stars = arr
  end

  def render
    arr = []
    arr << [0, 0, 1280, 720, 0, 0, 0].solids
    for s in @stars
      x = s[0]
      y = s[1]
      sh = s[2]
      r = s[3]
      arr << [x, y, sh, sh, 'sprites/star.png', r].sprites
    end
    arr
  end
end