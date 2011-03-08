module Gotcha

  class Base

    attr_reader :question, :answer

    # Determine whether or not an answer is correct
    def correct?(str)
      str = str.is_a?(String) ? str : str.to_s
      str == (@answer.is_a?(String) ? @answer : @answer.to_s) # don't change @answer type
    end

    # A default implementation of down_transform - adds the ability to make transforms fuzzy
    def self.down_transform(text)
      text = text.is_a?(String) ? text.dup : text.to_s
      text.downcase!
      text.gsub! /\s+/, ''
      text
    end

  end

end
