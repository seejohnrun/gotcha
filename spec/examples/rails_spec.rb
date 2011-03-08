require File.dirname(__FILE__) + '/../spec_helper'

class SamplesController < ActionController::Base

  # To make testing easier
  def flash
    @flash ||= {}
  end

end
