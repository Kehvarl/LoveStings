class Ship < SpriteSheet
  def initialize(opts)
    super(opts)
    @thrust_path = false
  end

  def render
    arr = []
    if @thrust_path
      arr << {x: @x, y: @y, w:@w, h:@h, path:@thrust_path, angle: 270}.sprite!
    end
  end

  def tick args
    if args.inputs.keyboard.up
      @y += 1
      @thrust_path = 'sprites/ThrustR.png'
    elsif args.inputs.keyboard.down
      @y -= 1
      @thrust_path = 'sprites/ThrustL.png'
    elsif args.inputs.keyboard.left
      @thrust_path = 'sprites/ThrustB.png'
    elsif args.inputs.keyboard.right
      @thrust_path = 'sprites/ThrustF.png'
    else
      @thrust_path = false
    end
  end
end
