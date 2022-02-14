def tick args
  args.state.starfield ||= Starfield.new()
  args.state.starfield.tick()

  args.outputs.primitives << args.state.starfield.render()
  args.outputs.primitives << [640, 360, 48, 48, 'sprites/ship_1.png', -90].sprites
end
