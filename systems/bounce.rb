# encoding: utf-8

class BounceSystem < System
  def update_entity(entity, window)
    return unless entity[Position]
    return unless entity[Velocity]

    raabb = raabb_for(entity)
    return if raabb.nil?

    if raabb.left < 0
      entity[Velocity].x = entity[Velocity].x.abs
    end

    if raabb.right > window.width
      entity[Velocity].x = - entity[Velocity].x.abs
    end

    if raabb.top < 0
      entity[Velocity].y = entity[Velocity].y.abs
    end

    if raabb.bottom > window.height
      entity[Velocity].y = - entity[Velocity].y.abs
    end
  end

  def draw(entities, window)
    entities.each do |entity|
      aabb = aabb_for(entity)
      raabb = raabb_for(entity)
      next if aabb.nil? || raabb.nil?

      # raabb
      color = Gosu::Color::GREEN
      window.draw_line(
        raabb.left, raabb.top, color,
        raabb.left, raabb.bottom, color
      )
      window.draw_line(
        raabb.right, raabb.top, color,
        raabb.right, raabb.bottom, color
      )
      window.draw_line(
        raabb.left, raabb.top, color,
        raabb.right, raabb.top, color
      )
      window.draw_line(
        raabb.left, raabb.bottom, color,
        raabb.right, raabb.bottom, color
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
    Rect.new(
      entity[Position].y - entity[CollisionBox].height / 2,
      entity[Position].x + entity[CollisionBox].width / 2,
      entity[Position].y + entity[CollisionBox].height / 2,
      entity[Position].x - entity[CollisionBox].width / 2,
    )
  end

  def aabbr_for(entity)
  end

  def rotate_point(px, py, cx, cy, rad)
    rx =
      Math.cos(rad) * (px - cx) -
      Math.sin(rad) * (py - cy) + cx

    ry =
      Math.sin(rad) * (px - cx) +
      Math.cos(rad) * (py - cy) + cy

    Point.new(rx, ry)
  end

  def raabb_for(entity)
    aabb = aabb_for(entity)
    return nil if aabb.nil?

    points = [
      Point.new(aabb.left,  aabb.top),
      Point.new(aabb.right, aabb.top),
      Point.new(aabb.right, aabb.bottom),
      Point.new(aabb.left,  aabb.bottom),
    ]

    if entity[Rotation]
      center = entity[Position]
      rad = entity[Rotation].rad
      points.map! do |point|
        rotate_point(point.x, point.y, center.x, center.y, rad)
      end
    end

    new_top    = points.min_by(&:y).y
    new_right  = points.max_by(&:x).x
    new_bottom = points.max_by(&:y).y
    new_left   = points.min_by(&:x).x

    Rect.new(new_top, new_right, new_bottom, new_left)
  end
end
