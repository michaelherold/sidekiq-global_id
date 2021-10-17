# frozen_string_literal: true

require "global_id"

GlobalID.app = :testing

module Fakes
  class User
    include GlobalID::Identification

    def self.all
      instances.values
    end

    def self.find(id)
      id = id.to_i
      instances.fetch(id)
    end

    def self.instances
      @instances ||= {}
    end

    def self.next_id
      current_max = instances.keys.max || 0
      current_max.succ
    end

    class << self
      alias create! new
    end

    def initialize(id: self.class.next_id)
      id = id.to_i
      @id = id
      self.class.instances[id] = self
    end

    attr_reader :id
  end
end
