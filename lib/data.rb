# frozen_string_literal: true

require 'yaml'

# Dynamically constructed attributes
class Env
  # Read YAML data from file
  def self.from_file(name = 'watched/scope.yaml')
    hash = YAML.load_file(name)
    Env.new(hash)
  end

  # See https://stackoverflow.com/q/1630815/553865
  def initialize(hash)
    hash.values[0].each do |item|
      item.each do |key, value|
        make_property(key, value)
      end
    end
  end

  # Make a new property with the given key and value
  def make_property(key, value)
    instance_variable_set("@#{key}", value)
    eigenclass = class << self; self; end
    eigenclass.class_eval do
      attr_accessor key
    end
  end
end
