module Gotcha

  module FormHelpers

    # Propose a gotcha to the user - question and answer hash
    def gotcha 
      gotcha = Gotcha.random
      field = "gotcha_response[#{gotcha.class.name.to_s}-#{Digest::MD5.hexdigest(gotcha.class.down_transform(gotcha.answer))}]"
      (label_tag field, gotcha.question) + "\n" + (text_field_tag field)
    end

    # Return the gotcha error if its needed
    def gotcha_error
      t(:gotcha_validation_failed, :default => 'Failed to validate the Gotcha.') if @_gotcha_validated === false
    end

  end

end
