class Ground_Generate
  def initialize
    @ground = generate_ground
    @x = 0
    @vx = 1
  end

  def generate_ground(width=2560, max_h=180, min_h = 5, max_change=5)
    arr = []
    w = 1
    x = -1
    h = min_h
    counter = 0
    target_y = rand(max_h)
    while x < width
      x += 1
      if (target_y - h).abs <= 1
        counter = rand(100)
      end
      if counter > 0
        counter -=1
        if counter <= 0
          target_y = [rand(max_h), min_h].max
          counter = 0
        end
      end
      if width - x <= [h, 50].max
        target_y = min_h
      end
      if h < target_y
        h += rand(max_change)
      elsif h > target_y
        h -= rand(max_change)
      end
      arr << {x:x, y:0, w:w, h:h, r:128, g:128, b:128}.solid!
    end
    arr
  end

  def tick args
    if args.inputs.keyboard.key_down.right
      @vx += 1
    end
    if args.inputs.keyboard.key_down.left
      @vx -= 1
    end
    # @x += @vx
    args.outputs.primitives << @ground.map do |g|
      g[:x] = (g[:x] - @vx) % 2560
      g
    end
  end
end
