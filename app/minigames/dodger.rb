class Minigame_Dodger
  def initialize
    @lives = 3
    @ship = Ship.new(x: 640, y: 360, w: 32, h: 32, angle: 270, path: 'sprites/Ship/ship_1-Sheet.png')
    @enemies = []
    @toast = []
    @background = []
    @effects = []
    @next_enemy = 60
    @lives = 3
    @score = 0
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

  def new_toast
    s = [16, 32].sample
    t = RotatingSprite.new(x: rand(64) + 1280, y: rand(670 - s -s) + s,
                           w: s, h: s, angle: rand(360),
                           rotation: 3,
                           vx: rand(10)/10,
                           max_delay: rand(5) + 5,
                           path: 'sprites/toast.png')
    valid = true
    @enemies.each do |old|
      if old.rect.intersect_rect?(t.rect)
        valid = false
      end
    end
    @toast.each do |old|
      if old.rect.intersect_rect?(t.rect)
        valid = false
      end
    end
    if valid
      @toast << t
    end
  end

  def toast_tick
    arr = []
    @toast.each do |t|
      t.x -= t.vx
      if t.x + [t.w, t.h].max > 0
        t.tick()
        arr << t
      end
    end
    @toast = arr
  end

  def new_enemy
    s = [16, 32, 64].sample
    e =  RotatingSprite.new(x: rand(64) + 1280, y: rand(670 -s -s) + s,
                            w: s,
                            h: s, angle: rand(360),
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
      if e.x + [e.w, e.h].max > 0
        e.tick()
        arr << e
      end
    end
    @enemies = arr
  end

  def tick args
    if @lives <= 0
      return
    end
    @next_enemy -= 1
    if @next_enemy == 0
      new_enemy
      if rand(10) >= 7
        new_toast
      end
      @next_enemy = 60
    end
    if @ship.exists
      @ship.tick(args)
    end
    enemy_tick
    toast_tick
    @effects.map{ |e| e.tick}
    @effects = @effects.select{ |e| !e.completed}
    if @effects.length == 0
      @ship.exists = true
    end

    args.outputs.primitives << {x: 0, y: 0, w: 1280, h: 720, r: 0, g: 0, b: 0}.solid!
    if @ship.exists
      args.outputs.primitives << @ship
    end
    args.outputs.primitives << @enemies.map { |e|  e}
    args.outputs.primitives << @toast.map { |t|  t}


    args.outputs.primitives << @enemies.map do |e|
      r = e.rect
      if @ship.exists and r.intersect_rect?(@ship.rect)
        @effects << Explosion.new(x: @ship.x, y: @ship.y)
        @ship.exists = false
        @lives -= 1
        @ship.vx = @ship.vy = 0
        {x:r[0], y:r[1], w:r[2], h:r[3], r:128, g:0, b:0, angle: e.angle}.border!
      end
    end

    args.outputs.primitives << @toast.map do |e|
      r = e.rect
      if @ship.exists and r.intersect_rect?(@ship.rect)
        @score += 100
        e.exists = false
        {x:r[0], y:r[1], w:r[2], h:r[3], r:0, g:128, b:0, angle: e.angle}.border!
      end
    end
    @toast = @toast.select { |t| t.exists}

    args.outputs.primitives << @effects.map { |e|  e}

    args.outputs.primitives << {x: 100, y: 689, w: 20, h: 20, path: 'sprites/toast.png'}.sprite!
    args.outputs.primitives << {x: 120, y: 710,
                                text: ": #{@score.to_s.rjust(3, '0')}",
                                size_enum: 2,
                                r:0, g:255, b:0}.label!
    args.outputs.primitives << {x: 1050, y: 683, w: 32, h: 32, path: 'sprites/Ship.png'}.sprite!
    args.outputs.primitives << {x: 1080, y: 710,
                                text: ": #{@lives}",
                                size_enum: 2,
                                r:0, g:255, b:0}.label!
    args.outputs.primitives << {x: 0, y: 675, x2: 190, y2: 675, r: 0, g: 128, b: 0}.line!
    args.outputs.primitives << {x: 190, y: 675, x2: 210, y2: 715, r: 0, g: 128, b: 0}.line!
    args.outputs.primitives << {x: 210, y: 715, x2: 1010, y2: 715, r: 0, g: 128, b: 0}.line!
    args.outputs.primitives << {x: 1010, y: 715, x2: 1030, y2: 675, r: 0, g: 128, b: 0}.line!
    args.outputs.primitives << {x: 1030, y: 675, x2: 1280, y2: 675, r: 0, g: 128, b: 0}.line!
    #args.outputs.primitives << @background.map { |g|  g}

    #@background = ground_tick
  end
end
