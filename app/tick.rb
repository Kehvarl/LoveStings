def tick args
  args.state.starfield ||= Starfield.new()
  args.state.ship_y ||= 360
  args.state.ship_angle ||= 270

  if args.inputs.mouse.click
    args.state.starfield.reverse()
    # args.state.ship_angle = (args.state.ship_angle + 180)%360
  end

  if args.inputs.keyboard.left
    args.state.starfield.vx += 0.01
  elsif args.inputs.keyboard.right
    args.state.starfield.vx -= 0.01
  end

  if args.inputs.keyboard.up
    args.state.ship_y += 1
  elsif args.inputs.keyboard.down
    args.state.ship_y -= 1
  end


  if args.state.starfield.vx < 0
    args.state.ship_angle = 270
  elsif args.state.starfield.vx > 0
    args.state.ship_angle = 90
  end

  args.state.starfield.tick()

  args.outputs.primitives << args.state.starfield.render()
  args.outputs.primitives << {x: 640, y: args.state.ship_y, w:48, h:48, path:'sprites/ship_1.png', angle: args.state.ship_angle}.sprite!
end
