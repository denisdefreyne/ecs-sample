# encoding: utf-8

class System
  def update(entities, window)
    entities.each { |e| update_entity(e, window) }
  end

  def update_entity(_entity, _window)
  end

  def draw(_entities, _window)
  end
end
