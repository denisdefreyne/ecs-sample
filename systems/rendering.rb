# encoding: utf-8

class RenderingSystem < System
  def update_entity(entity, window)
    image = entity[Image]
    image_inst = entity[ImageInst]

    if image && image_inst.nil?
      gosu_image = Gosu::Image.new(window, image.filename, true)
      entity.add(ImageInst.new(gosu_image))
    end
  end

  def draw(entities)
    entities.each do |entity|
      image_inst = entity[ImageInst]
      position = entity[Position]
      rotation = entity[Rotation]

      next if image_inst.nil?
      next if position.nil?

      rad = rotation ? rotation.rad : 0
      image_inst.image.draw_rot(position.x, position.y, 0, rad)
    end
  end
end
