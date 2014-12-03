# encoding: utf-8

class MovementSystem < System
  def update_entity(entity, _window)
    return unless entity[Position]

    unless entity[Velocity]
      entity.add(Velocity.new(0, 0))
    end

    if entity[Acceleration]
      entity[Velocity] += entity[Acceleration]
    end

    entity[Position] += entity[Velocity]
  end
end
