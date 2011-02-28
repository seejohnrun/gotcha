# Gotcha

This is just a simple way to write captchas based on logic of your choice.

    class JohnCaptcha < Gotcha::Base
      def initialize
        @question = 'who made this?'
        @answer = 'john'
      end
    end

		Gotcha.register_type JohnCaptcha
    Gotcha.random # get a random captcha
