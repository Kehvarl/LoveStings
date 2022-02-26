class Jelly < SpriteSheet
  def initialize(opts)
    super(opts)
    @next = 'relaxed'
    send(@next)
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