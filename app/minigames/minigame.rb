class Minigame
  attr_accessor :running, :score, :lives
  def initialize
    @running = true
    @ship = Ship.new(x: 640, y: 360, w: 32, h: 32, angle: 270, path: 'sprites/ship/ship_1-Sheet.png')
    @enemies = []
    @next_enemy = 120
    @collectables = []
    @effects = []
    @score = 0
    @collection = {}
    @lives = 3
  end

  def draw_header
    arr = []
    arr << {x: 100, y: 689, w: 20, h: 20, path: 'sprites/toast.png'}.sprite!
    arr << {x: 120, y: 710,
            text: ": #{@score.to_s.rjust(3, '0')}",
            size_enum: 2,
            r:0, g:255, b:0}.label!
    arr << {x: 1050, y: 683, w: 32, h: 32, path: 'sprites/Ship.png'}.sprite!
    arr << {x: 1080, y: 710,
            text: ": #{@lives}",
            size_enum: 2,
            r:0, g:255, b:0}.label!
    arr << {x: 0, y: 675, x2: 190, y2: 675, r: 0, g: 128, b: 0}.line!
    arr << {x: 190, y: 675, x2: 210, y2: 715, r: 0, g: 128, b: 0}.line!
    arr << {x: 210, y: 715, x2: 1010, y2: 715, r: 0, g: 128, b: 0}.line!
    arr << {x: 1010, y: 715, x2: 1030, y2: 675, r: 0, g: 128, b: 0}.line!
    arr << {x: 1030, y: 675, x2: 1280, y2: 675, r: 0, g: 128, b: 0}.line!
    arr
  end

  def tick args
    args.outputs.primitives << {x: 0, y: 0, w: 1280, h: 720, r: 0, g: 0, b: 0}.solid!
    if @ship.exists
      args.outputs.primitives << @ship
    end
  end
end
