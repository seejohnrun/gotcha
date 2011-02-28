module Gotcha

  class Base

    attr_reader :question

    def correct?(str)
      str = str.is_a?(String) ? str : str.to_s
      str == (@answer.is_a?(String) ? @answer : @answer.to_s) # don't change @answer type
    end

  end

  def self.unregister_all_types
    @@gotcha_types = []
  end

  def self.register_type(type)
    @@gotcha_types ||= []
    @@gotcha_types << type
  end

  def self.random
    if type = @@gotcha_types.sample
      type.new 
    end
  end

end
