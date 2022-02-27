class Ship < SpriteSheet
  def initialize(opts)
    super(opts)
    @thrust_path = false
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
    if args.inputs.keyboard.up
      @y += 1
      thrust_right
    elsif args.inputs.keyboard.down
      @y -= 1
      thrust_left
    elsif args.inputs.keyboard.left
      thrust_back
    elsif args.inputs.keyboard.right
      thrust_forward
    else
      thrust_none
    end
  end
end
