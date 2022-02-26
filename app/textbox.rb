class TextBox
  attr_accessor :x, :y, :w, :h, :text, :speaker
  def initialize opts
    super()
    @x = opts[:x] || 240
    @y = opts[:y] || 0
    @w = opts[:w] || 800
    @h = opts[:h] || 110
    @r = opts[:r] || 64
    @g = opts[:g] || 255
    @b = opts[:b] || 255
    @text = opts[:text] || "..."
    @speaker = opts[:speaker] || false
  end

  def render args
    arr = []
    if text
      arr = render_box(args, arr)
    end
    if speaker
      arr = render_speaker(args, arr)
    end
    arr
  end

  def render_box args, arr
    arr << [@x    , @y    , @w     , @h     , @r/4, @g/4, @b/4].borders
    arr << [@x + 1, @y + 1, @w -  2, @h -  2, @r/2, @g/2, @b/2].borders
    arr << [@x + 2, @y + 2, @w -  4, @h -  4, @r  , @g  , @b  ].borders
    arr << [@x + 3, @y + 3, @w -  6, @h -  6, @r/2, @g/2, @b/2].borders
    arr << [@x + 4, @y + 4, @w -  8, @h -  8, @r/4, @g/4, @b/4].borders
    arr << [@x + 6, @y + 5, @w - 10, @h - 10,    0,    0,    0].solids
    arr
  end

  def render_speaker args, arr
    w, h = args.gtk.calcstringbox(@speaker, 2)
    y = @y + @h
    arr << [@x    , y    , w + 12, h, @r/4, @g/4, @b/4].borders
    arr << [@x + 1, y - 1, w + 10, h, @r/2, @g/2, @b/2].borders
    arr << [@x + 2, y - 2, w +  8, h, @r  , @g  , @b  ].borders
    arr << [@x + 3, y - 3, w +  6, h, @r/2, @g/2, @b/2].borders
    arr << [@x + 4, y - 4, w +  4, h, @r/4, @g/4, @b/4].borders
    arr << [@x + 5, y - 5, w +  2, h, 0   , 0   , 0   ].solids
    arr << {x:@x + 5,  y:y -4 + h, text: @speaker, size_enum: 2,
            r: 255, g: 255, b: 255}.label!
    arr.concat render_text(args)
  end

  def render_text args
    arr = []
    max_character_length = 67
    long_strings_split = args.string.wrapped_lines @text, max_character_length
    arr << long_strings_split.map_with_index do |s, i|
      { x: @x + 5, y: @h - 20 - (i * 25), size_enum: 2, text: s,
        r: 255, g: 255, b: 255,
        alignment_enum: 0, vertical_alignment_enum: 1}.label!
    end
    arr
  end
end
