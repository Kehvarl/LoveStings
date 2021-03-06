##
# This class defines a Sprite primitive for DRGTK.
# Contains ALL sprite properties AND primitive_marker
# From http://docs.dragonruby.org/#---different-sprite-representations
#
class Sprite
  attr_accessor :x, :y, :z, :w,:h, :path, :angle, :a, :r, :g, :b,
                :source_x, :source_y, :source_w, :source_h,
                :tile_x, :tile_y, :tile_w, :tile_h,
                :flip_horizontally, :flip_vertically,
                :angle_x, :angle_y,
                :angle_anchor_x, :angle_anchor_y, :blendmode_enum

  def rect
    [@x, @y, @w, @h]
  end

  def primitive_marker
    :sprite
  end
end

##
# This class represents a multi-frame animated Sprite based on a Sprite Sheet
class SpriteSheet < Sprite
  attr_accessor :animation
  def initialize(opts)
    super
    @animation = opts[:animation] || 3
    @frame = opts[:frame] || 0
    @frame_count = opts[:frame_count] || 5
    @x = opts[:x] || 0
    @y = opts[:y] || 0
    @w = opts[:w] || 32
    @h = opts[:h] || 32
    @angle = opts[:angle] || 0
    @source_w = opts[:source_w] || 32
    @source_h = opts[:source_h] || 32
    @source_x = opts[:source_x] || 0
    @source_y = opts[:source_y] || 0
    @r = opts[:r] || 255
    @g = opts[:g] || 255
    @b = opts[:b] || 255
    @flip_horizontally = opts[:flip_horizontally] || false
    @anim_delay = opts[:max_delay] || 10
    @max_delay = opts[:max_delay] || 10
    @loop = opts[:loop] || true
    @path = opts[:path] || ['sprites/error.png']
  end

  def tick
    @anim_delay -= 1
    if @anim_delay == 0
      @anim_delay = @max_delay
      if @loop
        @frame = (@frame + 1) % @frame_count
      else
        @frame = [@frame + 1, @frame_count].min
      end
    end
    @source_y = @animation * @source_h
    @source_x = @frame * @source_w
  end
end

##
# This class represents a multi-frame animated Sprite based on a Sprite Sheet
class RotatingSprite < Sprite
  attr_accessor :vx, :vy, :exists
  def initialize(opts)
    super
    @x = opts[:x] || 0
    @y = opts[:y] || 0
    @w = opts[:w] || 32
    @h = opts[:h] || 32
    @r = opts[:r] || 255
    @g = opts[:g] || 255
    @b = opts[:b] || 255
    @angle = 0
    @vx = opts[:vx] || 0
    @vy = opts[:vy] || 0
    @flip_horizontally = opts[:flip_horizontally] || false
    @rotation = opts[:rotation] || 1
    @max_delay = opts[:max_delay] || 10
    @rotate_delay = @max_delay
    @path = opts[:path] || ['sprites/error.png']
    @exists = true
  end

  def tick
    @rotate_delay -= 1
    if @rotate_delay == 0
      @rotate_delay = @max_delay
      @angle = (@angle + @rotation) % 360
    end
  end
end