def tick args
  args.state.starfield ||= Starfield.new()
  args.state.jelly ||= Jelly.new(x: 640, y: 420, w: 64, h: 64, path: 'sprites/jelly.png')
  args.state.ship ||= Ship.new(x: 640, y: 360, w: 48, h: 48, angle: 270, path: 'sprites/Ship.png')

  if args.state.starfield.vx < 0
    args.state.ship.angle = 270
  elsif args.state.starfield.vx > 0
    args.state.ship.angle = 90
  end

  args.state.starfield.tick(args)
  args.state.ship.tick(args)
  args.state.jelly.tick(args)

  args.outputs.primitives << args.state.starfield.render
  args.outputs.primitives << args.state.jelly
  args.outputs.primitives << args.state.ship
  args.outputs.primitives << args.state.ship.render
end
