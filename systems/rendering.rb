# encoding: utf-8

class RenderingSystem < System
  def initialize(asset_manager)
    @asset_manager = asset_manager
  end

  def draw(entities)
    entities.each do |entity|
      image = entity[Image]
      position = entity[Position]
      rotation = entity[Rotation]

      next if image.nil?
      next if position.nil?

      deg = rotation ? rotation.deg : 0
      @asset_manager.image_at(image.filename)
        .draw_rot(position.x, position.y, 0, deg)
    end
  end
end
