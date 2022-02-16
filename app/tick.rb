def tick args
  args.state.starfield ||= Starfield.new()
  args.state.ship_angle ||= 270

  if args.inputs.mouse.click
    args.state.starfield.reverse()
    args.state.ship_angle = (args.state.ship_angle + 180)%360
  end

  args.state.starfield.tick()

  args.outputs.primitives << args.state.starfield.render()
  args.outputs.primitives << {x:640, y:360, w:48, h:48, path:'sprites/ship_1.png', angle: args.state.ship_angle}.sprite!
end
