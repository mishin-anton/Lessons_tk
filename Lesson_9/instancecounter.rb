
module InstanceCounter
  attr_reader :instances

  def self.included(base)
    base.extend ClassMethods
  end

  private

  def register_instance
    self.class.instance_increment
  end

  module ClassMethods
    def instances
      puts "NSTANCES #{@instances}"
    end

    def instance_increment
      @instances ||= 0
      @instances += 1
    end
  end
end
