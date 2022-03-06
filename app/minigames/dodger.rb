class Minigame_Dodger < Minigame
  def initialize
    super
    while @enemies.length < 5
      new_enemy
    end
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
    @collectables.each do |old|
      if old.rect.intersect_rect?(t.rect)
        valid = false
      end
    end
    if valid
      @collectables << t
    end
  end

  def toast_tick
    arr = []
    @collectables.each do |t|
      t.x -= t.vx
      if t.x + [t.w, t.h].max > 0
        t.tick()
        arr << t
      end
    end
    @collectables = arr
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

  def tick_calculations args
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

    @enemies.map do |e|
      r = e.rect
      if @ship.exists and r.intersect_rect?(@ship.rect)
        @effects << Explosion.new(x: @ship.x, y: @ship.y)
        @ship.exists = false
        @lives -= 1
        @ship.vx = @ship.vy = 0
      end
    end

    @collectables.map do |e|
      r = e.rect
      if @ship.exists and r.intersect_rect?(@ship.rect)
        @score += 100
        e.exists = false
      end
    end
    @collectables = @collectables.select { |t| t.exists}
  end

  def tick args
    super args
    tick_calculations args

    args.outputs.primitives << @enemies.map { |e|  e}
    args.outputs.primitives << @collectables.map { |t|  t}

    args.outputs.primitives << @effects.map { |e|  e}
    args.outputs.primitives << draw_header
  end
end
