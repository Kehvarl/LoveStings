class Minigame_Dodger
  def initialize
    @lives = 3
    @ship = Ship.new(x: 640, y: 360, w: 32, h: 32, angle: 270, path: 'sprites/Ship/ship_1-Sheet.png')
    @enemies = []
    new_enemy
    new_enemy
    new_enemy
    @ship.angle = 270
  end

  def new_enemy
    e =  SpriteSheet.new(x: rand(64) + (1280 - 128), y: rand(688), w: 64, h: 64, angle: rand(360),
                                animation: 0, frame_count: 1,
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


  def tick args
    @ship.tick(args)
    @enemies.each { |e| e.tick() }

    args.outputs.primitives << {x: 0, y: 0, w: 1280, h: 720, r: 0, g: 0, b: 0}.solid
    args.outputs.primitives << @ship
    args.outputs.primitives << @enemies.map { |e|  e}
  end
end
