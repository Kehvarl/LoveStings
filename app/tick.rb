def tick args
  args.state.starfield ||= Starfield.new()
  args.state.ship_y ||= 360
  args.state.ship_angle ||= 270
  tpath = false

  if args.inputs.mouse.click
    args.state.starfield.reverse()
    # args.state.ship_angle = (args.state.ship_angle + 180)%360
  end

  if args.inputs.keyboard.left
    args.state.starfield.vx += 0.01
    tpath = 'sprites/ThrustB.png'
  elsif args.inputs.keyboard.right
    args.state.starfield.vx -= 0.01
    tpath = 'sprites/ThrustF.png'
  end

  if args.inputs.keyboard.up
    args.state.ship_y += 1
    tpath = 'sprites/ThrustR.png'
  elsif args.inputs.keyboard.down
    args.state.ship_y -= 1
    tpath = 'sprites/ThrustL.png'
  end


  if args.state.starfield.vx < 0
    args.state.ship_angle = 270
  elsif args.state.starfield.vx > 0
    args.state.ship_angle = 90
  end

  args.state.starfield.tick()

  args.outputs.primitives << args.state.starfield.render()
  args.outputs.primitives << {x: 640, y: args.state.ship_y, w:48, h:48, path:'sprites/Ship.png', angle: args.state.ship_angle}.sprite!
  if tpath
    args.outputs.primitives << {x: 640, y: args.state.ship_y, w:48, h:48, path:tpath, angle: 270}.sprite!
  end
end
