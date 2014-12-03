# encoding: utf-8

class InputSystem < System
  def update_entity(entity, window)
    return unless entity[Input]

    # Turn
    entity.add(Rotation.new(0)) if entity[Rotation].nil?
    if window.button_down?(Gosu::KbLeft)
      entity[Rotation].rad -= 5.0
    end
    if window.button_down?(Gosu::KbRight)
      entity[Rotation].rad += 5.0
    end

    # Accelerate
    entity.add(Acceleration.new(0, 0))
    if window.button_down?(Gosu::KbUp)
      factor = Math::PI * 2 / 360.0
      entity[Acceleration].x = 0.3 * Math.cos(entity[Rotation].rad * factor)
      entity[Acceleration].y = 0.3 * Math.sin(entity[Rotation].rad * factor)
    end

    # Slow down
    if entity[Velocity] && window.button_down?(Gosu::KbDown)
      entity[Velocity] *= 0.9
    end
  end
end
