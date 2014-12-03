# encoding: utf-8

class BounceSystem < System
  THRESHOLD_X = 50.0
  THRESHOLD_Y = 50.0

  def update_entity(entity, window)
    return unless entity[Position]
    return unless entity[Velocity]

    if entity[Position].x < THRESHOLD_X
      entity[Velocity].x = entity[Velocity].x.abs
    end

    if entity[Position].x > window.width - THRESHOLD_X
      entity[Velocity].x = - entity[Velocity].x.abs
    end

    if entity[Position].y < THRESHOLD_Y
      entity[Velocity].y = entity[Velocity].y.abs
    end

    if entity[Position].y > window.height - THRESHOLD_Y
      entity[Velocity].y = - entity[Velocity].y.abs
    end
  end
end
