**This doc is just a draft, more detail coming soon**

# Gotcha

This is just a simple way to write captchas based on logic of your choice.  The inspiration here was the want to ask custom questions without a weird database table.

    class JohnCaptcha < Gotcha::Base
      def initialize
        @question = 'who made this?'
        @answer = 'john'
      end
    end

		Gotcha.register_type JohnCaptcha

---

## Gotchas

There are a few captchas implemented and installed by default:

* **SumGotcha** - Two random numbers, ask the user for the sum of them

---

## In your forms:

    = form_for @thing do |f|
      = gotcha_error
      = gotcha
      = f.submit

---

## In your controller

    def new
      @thing = Thing.new
    end

    def create
      @thing = Thing.new(params[:thing])
      if gotcha_valid? && @thing.save
        redirect_to @thing
      else
        render :new
      end
    end

---

## Multiple Gotchas in a page?

    = form_for @thing do |f|
      = gotcha_error
      - 10.times { gotcha }
      = f.submit

---

## Writing your own Gotchas

When writing your own gotchas, you may want the answers to be able to flex a bit, like allowing users to enter things in different cases.  In that case, your Gotcha can just override `self.down_transform` with whatever logic you want.  It takes a single argument, `text` which is the text of the answer.  You are expected to put it in a form that it would match regardless of the cases you want.  By default, `self.down_transform` is implemented as:

    def self.down_transform(text)
      text = text.is_a?(String) ? text.dup : text.to_s
      text.downcase!
      text.gsub(/\s+/, ' ')
      text
    end

Meaning by default, space types don't matter - and case is insensitive.

---

## Installing your gotchas

    Gotcha.unregister_all_types # Remove pre-defined
    Gotcha.register_type SumGotcha

---

## Determine if the gotcha was valid

You have a few ways to determine whether or not a Gotcha was valid.  You can use `gotcha_valid?` in views and controllers, or use `validate_gotcha!` (which throws a `Gotcha::ValidationException` if the Gotcha was not valid) in your controllers.

---

### License

MIT License.   See attached
