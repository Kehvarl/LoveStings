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

  def primitive_marker
    :sprite
  end
end

##
# This class represents a multi-frame animated Sprite
class Animated < Sprite
  attr_accessor :animation
  def initialize opts
    super
    @animation = opts[:animation] || 3
    @frame = opts[:frame] || 0
    @frame_count = opts[:frame_count] || 5
    @x = opts[:x] || 0
    @y = opts[:y] || 0
    @w = opts[:w] || 32
    @h = opts[:h] || 32
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
    @path = opts[:path] || ['sprites/error.png']
  end

  def tick
    @anim_delay -= 1
    if @anim_delay == 0
      @anim_delay = @max_delay
      @frame = (@frame + 1) % @frame_count
    end
    @source_y = @animation * @source_h
    @source_x = @frame * @source_w
  end
end