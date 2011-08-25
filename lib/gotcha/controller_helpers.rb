module Gotcha

  module ControllerHelpers

    def self.included(base)
      base.send(:helper_method, :gotcha_valid?)
    end 

    # return a true / false as to whether or not *all* of the gotchas on the page validated
    def gotcha_valid?(expected = 1)
      return true if defined?(Rails) && Rails.env == 'test' && Gotcha.skip_in_test
      @_gotcha_validated ||= determine_gotcha_validity(expected)
    end
      
    # Validate the gotcha, throw an exception if the gotcha does not validate (any on the page)
    def validate_gotcha!(expected = 1)
      raise Gotcha::ValidationError.new unless gotcha_valid?(expected)
    end

    private

    # Go through each response, using the down_transform
    # of the original class (as long as it is a subclass of Gotcha::Base)
    # and compare the hash to the hash of the value
    def determine_gotcha_validity(expected_gotcha_count = 1)
      return false unless params[:gotcha_response].kind_of?(Enumerable)    
      return false unless params[:gotcha_response].count == expected_gotcha_count
      params[:gotcha_response].all? do |ident, value|
        type, hash = ident.split '-'
        return false unless Object.const_defined?(type)
        return false unless (klass = Object.const_get(type)) < Gotcha::Base
        Digest::MD5.hexdigest(klass.down_transform(value)) == hash
      end
    end

  end

end
