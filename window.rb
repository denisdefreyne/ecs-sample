# encoding: utf-8

class Window < Gosu::Window
  def initialize(width, height, caption, entities, systems)
    super(width, height, false)
    self.caption = caption

    @entities = entities
    @systems = systems
  end

  def update
    @systems.each { |s| s.update(@entities, self) }
  end

  def draw
    @systems.each { |s| s.draw(@entities) }
  end
end
