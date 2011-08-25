require File.dirname(__FILE__) + '/../spec_helper'

describe Gotcha do

  before :all do
    Gotcha.unregister_all_types
  end

  before :all do
    class NextNumberGotcha < Gotcha::Base
      def initialize
        @question = '1, 2, 3, ?'
        @answer = 4
      end
    end
    Gotcha.register_type(NextNumberGotcha)
  end

  it 'should not skip validation by default' do
    Gotcha.skip_validation?.should be_false
  end

  it 'should be able to be told to skip validation' do
    Gotcha.skip_validation = true
    Gotcha.skip_validation?.should be true
  end

  it 'should be able to select a random type of gotcha' do
    gotcha = Gotcha.random
    gotcha.should be_a(Gotcha::Base)
  end

  it 'should be able to get the question for a gotcha' do
    gotcha = Gotcha.random
    gotcha.question.should_not be_empty
  end

  it 'should be able to check the answer' do
    gotcha = Gotcha.random
    gotcha.correct?(4).should be_true
  end

  it 'should be able to check the answer even if we supply a string' do
    gotcha = Gotcha.random
    gotcha.correct?('4').should be_true
  end

  it 'should be able to verify it got the wrong answer' do
    gotcha = Gotcha.random
    gotcha.correct?(5).should be_false
  end

end
