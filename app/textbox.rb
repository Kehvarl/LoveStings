class TextBox
  attr_accessor :text, :speaker
  def initialize opts
    super()
    @text = opts[:text] || "..."
    @speaker = opts[:speaker] || false
  end

  def render args
    arr = []
    arr << [240, 0, 800, 110, 64,  64,  64].borders
    arr << [241, 1, 798, 108,  0, 128, 128].borders
    arr << [242, 2, 796, 106,  0, 255, 255].borders
    arr << [243, 3, 794, 104,  0, 128, 128].borders
    arr << [244, 4, 792, 102, 64,  64,  64].borders
    arr << [245, 5, 790, 100,  0,   0,   0].solids
    if speaker
      arr = render_speaker(args, arr)
    end
    arr
  end

  def render_speaker args, arr
    w, h = args.gtk.calcstringbox(@speaker, 2)

    arr << [240, 110, w + 12, h, 64,  64,   64].borders
    arr << [241, 109, w + 10, h, 0,  128,  128].borders
    arr << [242, 108, w +  8, h, 0,  255,  255].borders
    arr << [243, 107, w +  6, h, 0,  128,  128].borders
    arr << [244, 106, w +  4, h, 0,   64,   64].borders
    arr << [244, 104, w +  2, h, 0,    0,    0].solids
    arr << {x:245,  y:106 + h, text: @speaker, size_enum: 2,
            r: 255, g: 255, b: 255}.label!
    arr.concat render_text(args)
  end

  def render_text args
    arr = []
    max_character_length = 67
    long_strings_split = args.string.wrapped_lines @text, max_character_length
    arr << long_strings_split.map_with_index do |s, i|
      { x: 245, y: 90 - (i * 25), size_enum: 2, text: s,
        r: 255, g: 255, b: 255,
        alignment_enum: 0, vertical_alignment_enum: 1}.label!
    end
    arr
  end
end
