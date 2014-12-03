# !/usr/bin/env ruby

require 'gosu'

require_relative 'asset_manager'
require_relative 'components'
require_relative 'entity'
require_relative 'system'
require_relative 'systems/input'
require_relative 'systems/movement'
require_relative 'systems/rendering'
require_relative 'systems/bounce'
require_relative 'window'

entities = []
systems = []

window = Window.new(800, 600, 'Spaaaace', entities, systems)

asset_manager = AssetManager.new(window)

entities << Entity.new(
  Position.new(400, 200),
  Velocity.new(1, 1),
  Image.new('assets/spaceship.png'),
  Input.new,
  CollisionBox.new(110, 110))

systems << MovementSystem.new
systems << RenderingSystem.new(asset_manager)
systems << InputSystem.new
systems << BounceSystem.new

window.show
