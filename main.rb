# !/usr/bin/env ruby

require 'gosu'

require_relative 'entity'
require_relative 'components'
require_relative 'system'
require_relative 'systems/input'
require_relative 'systems/movement'
require_relative 'systems/rendering'
require_relative 'systems/bounce'
require_relative 'window'

# Entities

entities = []

entities << Entity.new(
  Position.new(400, 200),
  Velocity.new(1, 1),
  Image.new('assets/spaceship.png'),
  Input.new)

# Systems

systems = [
  MovementSystem.new,
  RenderingSystem.new,
  InputSystem.new,
  BounceSystem.new,
]

# Gosu integration

window = Window.new(800, 600, 'Spaaaace', entities, systems)
window.show
