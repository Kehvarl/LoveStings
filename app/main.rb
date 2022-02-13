def newstarfield
  arr = []
  for s in 0..128
    x = rand(1280)
    y = rand(720)
    sh = rand(12) + 4
    c = rand(15)
    mc = c
    arr << [x, y, sh, c, mc]
  end
  arr
end

def calcstarfield old
  arr = []
  for s in old
    x = s[0]
    y = s[1]
    sh = s[2]
    c = s[3] - 1
    mc = s[4]
    if c <= 0
      x -= 1
      c = mc
    end
    if x < 0
      x = rand(4) + 1276
      y = rand(720)
      sh = rand(12) + 4
      c = rand(15)
      mc = c
    end
    arr << [x, y, sh, c, mc]
  end
  arr
end

def renderstarfield starfield
  arr = []
  arr << [0, 0, 1280, 720, 0, 0, 0].solids
  for s in starfield
    x = s[0]
    y = s[1]
    sh = s[2]
    arr << [x, y, sh, sh, 'sprites/star.png'].sprites
  end
  arr
end

def tick args
  args.state.starfield ||= newstarfield
  args.state.starfield = calcstarfield(args.state.starfield)

  args.outputs.primitives << renderstarfield(args.state.starfield)
end
