# encoding: utf-8

class BounceSystem < System
  def update_entity(entity, window)
    return unless entity[Position]
    return unless entity[Velocity]

    aabb = aabb_for(entity)
    return if aabb.nil?

    if aabb[:left] < 0
      entity[Velocity].x = entity[Velocity].x.abs
    end

    if aabb[:right] > window.width
      entity[Velocity].x = - entity[Velocity].x.abs
    end

    if aabb[:top] < 0
      entity[Velocity].y = entity[Velocity].y.abs
    end

    if aabb[:bottom] > window.height
      entity[Velocity].y = - entity[Velocity].y.abs
    end
  end

  private

  def aabb_for(entity)
    return nil unless entity[CollisionBox]

    top    = entity[Position].y - entity[CollisionBox].height / 2
    right  = entity[Position].x + entity[CollisionBox].width / 2
    bottom = entity[Position].y + entity[CollisionBox].height / 2
    left   = entity[Position].x - entity[CollisionBox].width / 2

    { top: top, right: right, bottom: bottom, left: left }
  end
end
