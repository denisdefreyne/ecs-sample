# encoding: utf-8

class Entity
  def initialize(*components)
    @components = {}

    components.each { |c| self.add(c) }
  end

  def [](klass)
     @components[klass]
  end

  def []=(klass, component)
    @components[klass] = component
  end

  def add(component)
    self[component.class] = component
  end
end
