def tick args
  args.state.starfield ||= Starfield.new()
  args.state.ship_y ||= 360
  args.state.ship_angle ||= 270
  thrust_path = false

  args.state.jelly ||= Jelly.new(x: 640, y: 420, w: 64, h: 64, path: 'sprites/jelly.png')

  if args.inputs.mouse.click
    args.state.starfield.reverse()
    args.state.jelly.next()
    # args.state.ship_angle = (args.state.ship_angle + 180)%360
  end

  if args.inputs.keyboard.left
    args.state.starfield.vx += 0.01
    thrust_path = 'sprites/ThrustB.png'
  elsif args.inputs.keyboard.right
    args.state.starfield.vx -= 0.01
    thrust_path = 'sprites/ThrustF.png'
  end

  if args.inputs.keyboard.up
    args.state.ship_y += 1
    thrust_path = 'sprites/ThrustR.png'
  elsif args.inputs.keyboard.down
    args.state.ship_y -= 1
    thrust_path = 'sprites/ThrustL.png'
  end

  if args.inputs.keyboard.key_down.space
    args.state.jelly.animation = [2, 3, 4].sample()
  end

  if args.inputs.keyboard.key_down.plus
    args.state.jelly.h += 8
    args.state.jelly.w = args.state.jelly.h
  end

  if args.inputs.keyboard.key_down.hyphen
    args.state.jelly.h = [(args.state.jelly.h - 4), 32].max
    args.state.jelly.w = args.state.jelly.h
  end


  if args.state.starfield.vx < 0
    args.state.ship_angle = 270
  elsif args.state.starfield.vx > 0
    args.state.ship_angle = 90
  end

  args.state.starfield.tick()
  args.state.jelly.tick()

  args.outputs.primitives << args.state.starfield.render()
  args.outputs.primitives << {x: 640, y: args.state.ship_y, w:48, h:48, path:'sprites/Ship.png', angle: args.state.ship_angle}.sprite!
  if thrust_path
    args.outputs.primitives << {x: 640, y: args.state.ship_y, w:48, h:48, path:thrust_path, angle: 270}.sprite!
  end
  args.outputs.primitives << args.state.jelly
end
