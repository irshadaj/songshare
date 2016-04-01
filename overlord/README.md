Super Villain's Detonation Device
=================================

## Part I
You've been contacted by a super villain in search of help. He says he has a great idea, and needs only your genius to bring it to completion. Turns out the idea is going to be a bomb. I mean, literally. It's a bomb. Still, he's offering equity.

One tricky problem is that bombs are quite expensive to debug in prod. To avoid an embarrassing dud, you're going to develop and test the bomb in the relative safety of your own workshop (desk, really). Thankfully, you've got requirements, so mostly this is just an exercise of translating those requirements into working tests and then writing the software to control the bomb. 

But, this is the important part: you're going to write all the behavioral tests for the device before you write any of the Sinatra app code. You cleverly realize that by writing the tests the way you'd like the code to work, you'll make your resulting code that much better. Well done, smartie.

One other thing. Your client is on a tight schedule, so we don't have time to make the bomb look too flashy.  We've got some [basic CSS](assets/stylesheets/bomb.css) that should help with the basic interface.

### Requirements
1. Even coffee machines have webservers these days. The bomb interface should be a Sinatra app, and the tests should be written in Cucumber and Rspec. A simple Sinatra base has been provided.
2. The bomb interface should include a field to type in an activation / deactivation code and an indicator of the activation state of the bomb.
3. When the super villain first boots the bomb, it should not be activated.
4. The activation code is pretty simple:
  * The code should be configurable on boot. If no code is specified, 1234 seems pretty safe. Validate that only numeric inputs are allowed.
  * When the correct activation code is entered, the bomb should activate. Putting in the same activation code again should have no effect. From now on, the status indicator should let the user know that the bomb is active.
5. Next, the deactivation code.
  * This code should be configurable as well. A good default code would be 0000.
  * Once the bomb is active, putting in the correct deactivation code should cause the bomb to revert to inactivity, and indicate as such.
  * If a user puts in the wrong deactivation code three times, the bomb should explode. I'm not really sure what the interface would look like for this, since the bomb is exploded and all, but let's just indicate it somehow to be sure.
  * Once a bomb has exploded, none of the buttons work anymore. Obv.
6. Use the existing CSS to develop a basic interface.  You may get the opportunity to design a better interface later _(hint, hint)_.


### Super Optional Bonus Points
* Add a "confirm" button to the activation sequence. Once the activation code is entered, the user must confirm by pressing a big red button. Figure out what happens if you bail from the confirmation.
* Add a timer. All good bombs have timers.
* Add wires to snip to stop the bomb from detonating. This guy seems like he might not pay on time.
* No bonus points for developing an actual electronic detonator. Still, dude, sweet.

## Part II
Nice job with the bomb, earlier!  Your client was very impressed!  Unfortunately, before he could go through with his evil scheme, he was captured by the authorities.  Control over his evil empire has now fallen into the hands of his son, Scott.

Scott is not as impressed.  He was looking forward to seeing something more flashy, with an awesome, malevolent-looking interface. _"Like in the movies."_

### Requirements
1. Redesign the bomb interface to look awesome.
2. Use HTML5 to develop semantic HTML.
3. Organize your new CSS according to SMACSS.
