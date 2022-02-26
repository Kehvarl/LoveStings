class Jelly < SpriteSheet
  def initialize(opts)
    super(opts)
    @portrait_w = opts[:source_w] || 32
    @portrait_h = opts[:source_h] || 32
    @portrait_x = opts[:source_x] || 0
    @portrait_y = opts[:source_y] || 128
    @next = 'relaxed'
    send(@next)
  end

  def render_portrait (x, y, w, h)
    {x: x,
     y: y,
     w: w,
     h: h,
     source_x: @portrait_x,
     source_y: @portrait_y,
     source_w: @portrait_w,
     source_h: @portrait_h,
     path: @path
    }.sprite!
  end

  def relaxed
    @animation = 4
    @frame_count = 5
    @loop = true
    @next = 'agitated'
  end

  def next_mood
    send(@next)
  end

  def agitated
    @animation = 3
    @frame_count = 5
    @loop = true
    @next = 'angry'
  end

  def angry
    @animation = 2
    @frame_count = 5
    @loop = true
    @next = 'explode'
  end

  def explode
    @animation = 1
    @frame_count = 7
    @loop = false
    @next = 'relaxed'
  end

  def flatten
    @animation = 0
    @frame_count = 3
    @loop = false
  end

  def tick args
    super()
    if args.inputs.keyboard.key_down.space
      next_mood()
    end

    if args.inputs.keyboard.key_down.plus
      @h += 8
      @w = @h
    end

    if args.inputs.keyboard.key_down.hyphen
      @h = [(@h - 4), 32].max
      @w = @h
    end
  end
end