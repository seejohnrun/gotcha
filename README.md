# Gotcha

Adding captchas to some action should be really easy.  It shouldn't require a migration, like [Brain Buster](https://github.com/rsanheim/brain_buster) or API calls like [reCAPTCHA](http://www.google.com/recaptcha).  Gotcha is an easy way to ask (custom) questions of your users in order for them to perform some action (like submitting a form).

---

## Installation

To install Gotcha, just run:

    $ gem install gotcha

Or put it in your Gemfile

    gem 'gotcha'

---

## Built-in Gotchas

There are a few captchas implemented and installed by default:

* **SumGotcha** - Two random numbers, ask the user for the sum of them
* **BackwardGotcha** - Ask the user to retype a random string backwards (case-insensitive)

A random Gotcha type will be generated on each call to `gotcha`

---

## Using Gotcha

### In your forms (HAML used for brevity):

    = form_for @thing do |f|
      = gotcha_error
      = gotcha
      = f.submit

### In your controller

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
      - 10.times do
        .gotcha= gotcha
      = f.submit

and in your controller

    gotcha_valid?(10)

---

## Writing your own Gotchas

To write your own Gotcha, all you have to do is extend `Gotcha::Base` and provide a `question` and an `answer`:

    class MyGotcha < Gotcha::Base
      def initialize
        @question = 'Who made this?'
        @answer = 'john'
      end
    end

When writing your own gotchas, you may want the answers to be able to flex a bit, like allowing users to enter things in different cases.  In that case, your Gotcha can just override `self.down_transform` with whatever logic you want.  It takes a single argument, `text` which is the text of the answer.  You are expected to put it in a form that it would match regardless of the cases you want.  By default, `self.down_transform` is implemented as:

    def self.down_transform(text)
      text = text.is_a?(String) ? text.dup : text.to_s
      text.downcase!
      text.gsub!(/\s+/, ' ')
      text.strip!
      text
    end

Meaning by default, space types don't matter - and case is insensitive.

---

## Installing your gotchas

In an initializer:

    Gotcha.unregister_all_types # Remove pre-defined
    Gotcha.register_type SumGotcha

---

## Determine if the gotcha was valid

You have a few ways to determine whether or not a Gotcha was valid.  You can use `gotcha_valid?` in views and controllers, or use `validate_gotcha!` (which throws a `Gotcha::ValidationException` if the Gotcha was not valid) in your controllers.

## Testing

In testing, it's sometimes useful to make validation always return true.  For this, you can use: `Gotcha.skip_validation = true`

---

## License

MIT License.   See attached
