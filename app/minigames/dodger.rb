class Minigame_Dodger
  def initialize
    @lives = 3
    @ship = Ship.new(x: 640, y: 360, w: 32, h: 32, angle: 270, path: 'sprites/Ship/ship_1-Sheet.png')
    @enemies = []
    @background = []
    @next_enemy = 60
    while @enemies.length < 5
      new_enemy
    end
    ground
  end

  def ground
    h = 64
    w = 1
    0.step(1290, w) do |x|
      h = [[(h + [-1,1].sample), 32].max, 256].min
      @background << {x:x, y:10, w:w, h:h, r:128, g:128, b:128}.solid!
    end
  end

  def ground_tick
    arr = []
    last_x = 0
    h = 64
    w = 1
    @background.each do |g|
      w = g[:w]
      h = g[:h]
      g[:x] -= 1
      if g[:x] + g[:w] > 0
        arr << g
        last_x = [last_x, g[:x]].max
      end
    end
    last_x.step(1290, w) do |x|
      h = [[(h + [-1,1].sample), 32].max, 256].min
      arr << {x:x, y:10, w:w, h:h, r:128, g:128, b:128}.solid!
    end
    @background = arr
  end

  def new_enemy
    e =  RotatingSprite.new(x: rand(64) + 1280, y: rand(688),
                            w: [16, 32, 64].sample,
                            h: [16, 32, 64].sample, angle: rand(360),
                            rotation: [-6, -4, -2, -1, 1, 2, 3, 4, 6].sample,
                            vx: [0.25, 0.5, 1].sample,
                            max_delay: rand(5) + 5,
                            path: 'sprites/meteor.png')
    valid = true
    @enemies.each do |old|
      if old.rect.intersect_rect?(e.rect)
        valid = false
      end
    end
    if valid
      @enemies << e
    end
  end

  def enemy_tick
    arr = []
    @enemies.each do |e|
      e.x -= e.vx
      e.tick()
      arr << e
    end
    arr
  end

  def tick args
    @next_enemy -= 1
    if @next_enemy == 0
      new_enemy
      @next_enemy = 60
    end
    @ship.tick(args)
    @enemies = enemy_tick

    args.outputs.primitives << {x: 0, y: 0, w: 1280, h: 720, r: 0, g: 0, b: 0}.solid!
    args.outputs.primitives << @ship
    args.outputs.primitives << @enemies.map { |e|  e}
    #args.outputs.primitives << @background.map { |g|  g}

    #@background = ground_tick
  end
end
