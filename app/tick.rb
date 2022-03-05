def tick args
  defend_tick args
end

def dodger_tick args
  args.state.dodger ||= Minigame_Dodger.new()
  args.state.dodger.tick(args)
end

def defend_tick args
  args.state.defend ||= Minigame_Defend.new()
  args.state.defend.tick(args)
end

def tech_tick args
  args.state.starfield ||= Starfield.new()
  args.state.jelly ||= Jelly.new(x: 640, y: 420, w: 64, h: 64, path: 'sprites/jelly.png')
  args.state.ship ||= Ship.new(x: 640, y: 360, w: 32, h: 32, angle: 270, path: 'sprites/Ship/ship_1-Sheet.png')
  long_string = "Lorem ipsum dolor sit amet, consectetur adipiscing elitteger dolor velit, ultricies vitae libero vel, aliquam imperdiet enim."
  args.state.textbox ||= TextBox.new(text: long_string + long_string, speaker: "Player")

  if args.state.starfield.vx < 0
    args.state.ship.angle = 270
  elsif args.state.starfield.vx > 0
    args.state.ship.angle = 90
  end

  args.state.starfield.tick(args)
  args.state.ship.tick(args)
  args.state.jelly.tick(args)

  if args.inputs.keyboard.key_down.space
    args.state.textbox.speaker = ['Player', 'Jelly', 'Space Pirate Captain'].sample
    args.state.textbox.text = [long_string, "The quick brown fox jumped over the lazy dog", "...", "And that's that!"].sample
  end

  args.outputs.primitives << args.state.starfield.render
  args.outputs.primitives << args.state.jelly
  args.outputs.primitives << args.state.ship
  args.outputs.primitives << args.state.textbox.render(args)
  # args.outputs.primitives << args.state.jelly.render_portrait(140, 45, 128, 128)

end
