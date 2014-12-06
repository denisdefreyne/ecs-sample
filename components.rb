# encoding: utf-8

Position = Struct.new(:x, :y) do
  def +(other)
    self.class.new(x + other.x, y + other.y)
  end
end

Velocity = Struct.new(:x, :y) do
  def +(other)
    self.class.new(x + other.x, y + other.y)
  end

  def *(factor)
    self.class.new(x * factor, y * factor)
  end
end

Acceleration = Struct.new(:x, :y)

Rotation = Struct.new(:deg) do
  def rad
    deg * Math::PI * 2 / 360.0
  end
end

Image = Struct.new(:filename)

Input = Class.new

CollisionBox = Struct.new(:width, :height)
