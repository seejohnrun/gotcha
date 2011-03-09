class SumGotcha < Gotcha::Base

  DEFAULT_MIN = 0
  DEFAULT_MAX = 20

  def initialize
    rand1 = self.class.random_number_in_range
    rand2 = self.class.random_number_in_range
    @question = ["What is the sum of #{rand1} and #{rand2}?", "What is #{rand1} + #{rand2}?"].sample
    @answer = rand1 + rand2
  end

  private

  def self.max
    @@max ||= DEFAULT_MAX
  end

  def self.min
    @@min ||= DEFAULT_MIN
  end

  def self.random_number_in_range
    rand(self.max - self.min) + self.min
  end

end

Gotcha.register_type SumGotcha
