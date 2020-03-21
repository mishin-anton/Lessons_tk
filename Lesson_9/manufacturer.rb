# frozen_string_literal: true

module Manufacturer
  def manufacturer_setup(name)
    @name = name
  end

  def manufacturer_get
    @name
  end
end
