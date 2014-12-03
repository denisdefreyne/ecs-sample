# encoding: utf-8

class BounceSystem < System
  def update_entity(entity, window)
    return unless entity[Position]
    return unless entity[Velocity]

    aabb = aabb_for(entity)
    return if aabb.nil?

    if aabb.left < 0
      entity[Velocity].x = entity[Velocity].x.abs
    end

    if aabb.right > window.width
      entity[Velocity].x = - entity[Velocity].x.abs
    end

    if aabb.top < 0
      entity[Velocity].y = entity[Velocity].y.abs
    end

    if aabb.bottom > window.height
      entity[Velocity].y = - entity[Velocity].y.abs
    end
  end

  def draw(entities, window)
    entities.each do |entity|
      aabb = aabb_for(entity)
      next if aabb.nil?

      color = Gosu::Color::GREEN
      window.draw_line(
        aabb.left, aabb.top, color,
        aabb.left, aabb.bottom, color
      )
      window.draw_line(
        aabb.right, aabb.top, color,
        aabb.right, aabb.bottom, color
      )
      window.draw_line(
        aabb.left, aabb.top, color,
        aabb.right, aabb.top, color
      )
      window.draw_line(
        aabb.left, aabb.bottom, color,
        aabb.right, aabb.bottom, color
      )
    end
  end

  private

  Point = Struct.new(:x, :y)

  Rect = Struct.new(:top, :right, :bottom, :left) do
    def top_left
      Point.new(top, left)
    end

    def top_right
      Point.new(top, right)
    end

    def bottom_right
      Point.new(bottom, right)
    end

    def bottom_left
      Point.new(bottom, left)
    end
  end

  def aabb_for(entity)
    return nil unless entity[CollisionBox]

    top    = entity[Position].y - entity[CollisionBox].height / 2
    right  = entity[Position].x + entity[CollisionBox].width / 2
    bottom = entity[Position].y + entity[CollisionBox].height / 2
    left   = entity[Position].x - entity[CollisionBox].width / 2

    points = [
      Point.new(left,  top),
      Point.new(right, top),
      Point.new(right, bottom),
      Point.new(left,  bottom),
    ]

    if entity[Rotation]
      center = entity[Position]
      rad = entity[Rotation].rad
      points.map! do |point|
        rotated_x =
          Math.cos(rad) * (point.x - center.x) -
          Math.sin(rad) * (point.y - center.y) + center.x
        rotated_y =
          Math.sin(rad) * (point.x - center.x) +
          Math.cos(rad) * (point.y - center.y) + center.y

        Point.new(rotated_x, rotated_y)
      end
    end

    new_top    = points.min_by(&:y).y
    new_right  = points.max_by(&:x).x
    new_bottom = points.max_by(&:y).y
    new_left   = points.min_by(&:x).x

    Rect.new(new_top, new_right, new_bottom, new_left)
  end
end
