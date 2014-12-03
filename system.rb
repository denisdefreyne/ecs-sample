# encoding: utf-8

class System
  def update(entities, window)
    entities.each { |e| update_entity(e, window) }
  end

  def update_entity(entity, _window)
  end

  def draw(entities)
  end
end
