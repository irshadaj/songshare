Super Villain's Private Safe
============================

## Part I
You've been contacted by your local super villain, Professor Nefarious in search of help. She says she has a great idea, and needs only your genius to protect it from snooping spies. She needs a safe.

Thankfully, you've got requirements, so mostly this is just an exercise of translating those requirements into working tests and then writing the software to control the safe.

But, this is the important part: you're going to write all the behavioral tests for the device before you write any of the Sinatra app code. You cleverly realize that by writing the tests the way you'd like the code to work, you'll make your resulting code that much better. Well done, smartie!

One other thing. Your client is on a tight schedule and spent all her money on pistol-packing pigeons, so we don't have the time or money to make the safe look too flashy.  We've stolen some [totally awesome styles from late 2008](public/stylesheets/safe.css) that should help with the basic interface.

### Setup
The safe interface will be a website running on Sinatra (see Requirements below). You'll be writing tests in Cucumber and RSpec. To get started follow these steps:

```bash
# Run bundler to install dependencies
bundle install

# Start the web server
ruby overlord.rb  # => now you can see it in your browser at http://localhost:4567

# Run your Cucumber tests
bundle exec cucumber
```

### Requirements
1. Even coffee machines have web servers these days. The safe interface should be a Sinatra app, and the tests should be written in Cucumber and Rspec. A simple Sinatra base has been provided.
2. The safe interface should include a field to type in the safe combination and an indicator of the locked state of the safe.
3. When the super villain first builds the safe, it should not be locked.
4. The safe combination is pretty simple:
  * The combination should be configurable on lock. If no combination is specified, 1234 seems pretty safe. Validate that only numeric inputs are allowed.
  * When the safe is locked and the correct combination is entered, the safe should unlock. From now on, the status indicator should let the user know that the safe is locked.
  * If a user puts in the wrong combination three times, the safe should deploy the relocker, preventing the safe from ever being opened.
  * Once a safe has relocked, none of the buttons work anymore. Obv.
6. Use the existing CSS to develop a basic interface.  You may get the opportunity to design a better interface later _(hint, hint)_.

## Part II
Nice job with the safe, earlier!  Your client was very impressed!  Unfortunately, before she could go through with her evil scheme, Prof. Nefarious was captured by the authorities.  Control over her evil empire has now fallen into the hands of her son, Rick Nefarious.

Rick is not as impressed.  He was looking forward to seeing something more flashy on his wall, with an awesome, malevolent-looking interface. _"Like in the movies."_  He's also willing to increase the project budget to make the safe look more badass.

### Requirements
1. Copy your old Overlord project in `overlord/` over to `overlord_2`.
2. Redesign the safe interface to look awesome.
3. Use HTML5 to develop semantic HTML.
4. Organize your new CSS according to SMACSS.
5. Get a feel for both the [ERB](http://guides.rubyonrails.org/layouts_and_rendering.html) and [HAML](http://haml.info/) templating languages.
