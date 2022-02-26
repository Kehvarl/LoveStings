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

  args.outputs.primitives << [240, 0, 800, 100, 64,  64,  64].borders
  args.outputs.primitives << [241, 1, 798,  98,  0, 128, 128].borders
  args.outputs.primitives << [242, 2, 796,  96,  0, 255, 255].borders
  args.outputs.primitives << [243, 3, 794,  94,  0, 128, 128].borders
  args.outputs.primitives << [244, 4, 792,  92, 64,  64,  64].borders
  args.outputs.primitives << [245, 5, 790,  90,  0,   0,   0].solids
  args.outputs.primitives << {x: 245, y: 80, size_enum: 2,
                              r: 255, g: 255, b: 255,
                              text: "Testing test text that needs tested...",
                              alignment_enum: 0, vertical_alignment_enum: 1}.label!

  long_string = "Lorem ipsum dolor sit amet, consectetur adipiscing elitteger dolor velit, ultricies vitae libero vel, aliquam imperdiet enim."
  max_character_length = 70
  long_strings_split = args.string.wrapped_lines long_string, max_character_length
  args.outputs.primitives << long_strings_split.map_with_index do |s, i|
    { x: 245, y: 55 - (i * 25), size_enum: 2, text: s,
      r: 255, g: 255, b: 255,
      alignment_enum: 0, vertical_alignment_enum: 1}.label!
  end
end
