# encoding: utf-8

class AssetManager
  def initialize(window)
    @window = window

    @images = {}
  end

  def image_at(filename)
    @images[filename] ||= Gosu::Image.new(@window, filename, true)
  end
end
