# encoding: utf-8

class BounceSystem < System
  def update_entity(entity, window)
    return unless entity[Position]
    return unless entity[Velocity]
    return unless entity[CollisionBox]

    if entity[Position].x < entity[CollisionBox].width / 2
      entity[Velocity].x = entity[Velocity].x.abs
    end

    if entity[Position].x > window.width - entity[CollisionBox].width / 2
      entity[Velocity].x = - entity[Velocity].x.abs
    end

    if entity[Position].y < entity[CollisionBox].height / 2
      entity[Velocity].y = entity[Velocity].y.abs
    end

    if entity[Position].y > window.height - entity[CollisionBox].height / 2
      entity[Velocity].y = - entity[Velocity].y.abs
    end
  end
end
