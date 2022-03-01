class Ship < SpriteSheet
  attr_accessor :vx, :vy, :reversed, :exists
  def initialize(opts)
    super(opts)
    @vx = 0.0
    @vy = 0.0
    @reversed = false
    @exists = true
  end

  def thrust_none
    @animation = 4
    @frame_count = 4
    @loop = true
  end

  def thrust_forward
    @animation = 3
    @frame_count = 4
    @loop = true
  end

  def thrust_back
    @animation = 2
    @frame_count = 4
    @loop = true
  end

  def thrust_left
    @animation = 1
    @frame_count = 4
    @loop = true
  end

  def thrust_right
    @animation = 0
    @frame_count = 4
    @loop = true
  end

  def tick args
    super()
    @y += @vy
    @x += @vx
    if @x >= (1280 - @w) or @x <= 0
      @vx = 0.0
    end
    if @y >= (720 - h) or @y <= 0
      @vy = 0
    end
    if args.inputs.keyboard.up
      #@y += 1
      @vy += 0.01
      if @reversed
        thrust_left
      else
        thrust_right
      end
    elsif args.inputs.keyboard.down
      #@y -= 1
      @vy -= 0.01
      if @reversed
        thrust_right
      else
        thrust_left
      end
    elsif args.inputs.keyboard.left
      @vx -= 0.01
      if @reversed
        thrust_forward
      else
        thrust_back
      end
    elsif args.inputs.keyboard.right
      @vx += 0.01
      if @reversed
        thrust_back
      else
        thrust_forward
      end
    else
      thrust_none
    end
  end
end

class Explosion < Sprite
  attr_accessor :completed
  def initialize opts
    super(opts)
    @path = opts[:path] || 'sprites/explosion.png'
    @x = opts[:x] || 0
    @y = opts[:y] || 0
    @h = opts[:h] ||32
    @w = opts[:w] ||32
    @delta = 1
    @max_size = opts[:max_size] ||64
    @max_delay = opts[:max_delay] || 2
    @anim_delay = @max_delay
    @completed = false
  end

  def tick
    @anim_delay -= 1
    if @anim_delay <= 0
      @anim_delay = @max_delay
      @h = (@w += @delta)
      @x -= @delta/2
      @y -= @delta/2
      if @h >= @max_size
        @delta = -(@delta.abs)
      end
      if @h <= 0
        @completed = true
      end
    end
  end
end