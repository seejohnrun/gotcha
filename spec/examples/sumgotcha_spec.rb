require File.dirname(__FILE__) + '/../../lib/gotcha/sum_gotcha'

describe SumGotcha do

  before(:all) do
    Gotcha.unregister_all_types
    Gotcha.register_type(SumGotcha)
  end

  it 'should be able to pose a question for a sum of two numbers' do
    gotcha = Gotcha.random
    gotcha.question.should =~ /What is the sum of (\d+) and (\d+)\?/
  end

  it 'should be able to pose a question for a sum of two numbers' do
    gotcha = Gotcha.random
    matches = gotcha.question.match /What is the sum of (\d+) and (\d+)\?/

    # should get the right answer for this simple one
    matches.should_not be_nil
    gotcha.correct?($1.to_i + $2.to_i).should be_true
  end

end
