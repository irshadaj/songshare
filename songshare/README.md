# Songshare

My S.O. is trying to expand my musical tastes, but I have no idea where to start.  I need some recommendations!

We have an app that can look up info about musical artists and songs.  However, it doesn't let me send or receive recommendations.  Your job is to add that functionality.

## Table of Contents
* [Overview](#overview)
* [The Exercise](#the-exercise)
  - [Part 0 - Getting Started](#part-0---getting-started)
  - [Part 1 - Behavioral Tests](#part-1---behavioral-tests)
  - [Part 2 - Controller](#part-2---controller)
  - [Part 3 - Views](#part-3---views)
  - [Part 4 - Model](#part-4---model)
* [Resources](#resources)
* [Enabling PostgreSQL Support](#enabling-postgresql-support)

## Overview

Songshare is written in Rails, a Ruby-based MVC framework.  The MVC architectural pattern separates applications into three interconnected parts: the **m**odel, **v**iew and **c**ontroller.  The **model** component is responsible for storing data and containing the business logic of the application.  The **view** generates output to the user.  In Rails, this output usually takes the form of HTML (for browsers) or JSON (for API consumers).  Finally, the **controller** links the two, accepting web requests from the client, sending messages to the model, and rendering the views based on the state of the model.  Take a look at the [resources](#resources) below for more information on MVC and Rails.  You can also learn more about the Rails directory structure from their [official guides](http://guides.rubyonrails.org/getting_started.html#creating-the-blog-application).

You'll notice in this application that there is already a lot of code here.  This is going to be a similar experience to working on your first production project.  There will be a lot of dependencies and existing code that you won't recognize or understand, and it may seem a bit overwhelming.  This is okay.  One of the keys to distinguishing yourself as an experienced engineer is developing the ability to compartmentalize your understanding--to be able to read a snippet of code, a class or a module, and move forward with very little context. That isn't to say that context doesn't help as it almost always does, but rather that you can make meaningful improvements without being a subject matter expert.

## The Exercise

### Part 0 - Getting Started
First, you'll need to get everything set up. Be sure to [set up an application with Spotify](https://developer.spotify.com/my-applications/#!/applications). Create a `.env` file in the project directory and set the `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` environment variables.  These environment variables *must* be present in order to initialize the application (server, RSpec, Cucumber, etc).

Set up your `SECRET_KEY_BASE` by running:

```sh
echo -e "\nSECRET_KEY_BASE=$( bundle exec rake secret )" >> .env
```

Use RSpec to execute the existing unit tests using the command `bundle exec rspec` _(see note below)_. You should make sure everything passes, and then stand the app up and make sure you can navigate to it in your browser.

\* _Note that RSpec will take some time to run the first time.  Some of the tests rely upon the Spotify API.  VCR caches the responses from these calls, so expect subsequent test runs to be faster._

### Part 1 - Behavioral Tests
As with any behavior-driven developed program, you'll be starting with the tests.  Add a series of [Cucumber](https://cucumber.io) features for recommending songs, liking recommendations, and looking at your incoming and outgoing recommendations.

```
As a user
I want to see what songs have been recommended to me
In order to decide what to listen to
```

```
As a user
I want to recommend my songs to others
In order to help them expand their interests
```

```
As a user
I want to see what songs I have recommended
In order to recommend others to them
```

```
As a user
I want to mark a recommendation to me as 'liked' or 'disliked'
In order for my friends to adjust their recommendations accordingly
```

Keep in mind that this outside-in approach will require you to mock some objects (especially models).  Take a look at [RSpec mocks](https://www.relishapp.com/rspec/rspec-mocks/docs) for reference.

### Part 2 - Controller
Now let's add a [controller](http://edgeguides.rubyonrails.org/action_controller_overview.html) to receive requests related to our recommendations and respond with the appropriate rendered view.

### Part 3 - Views
Now that we have some behavioral tests up, let's add some views.  Use [Haml](http://haml.info) to modify the existing song list and add a "Recommend" option to each song. Also add a view to see your recommendations (incoming and outgoing)

### Part 4 - Model
Finally, we need to create the Recommendation [model](http://edgeguides.rubyonrails.org/active_record_basics.html) and appropriate [database migration](http://edgeguides.rubyonrails.org/active_record_migrations.html).  The model should [reference](http://edgeguides.rubyonrails.org/association_basics.html) a `Song` and a pair of `User`s (one source, one target).

## Resources
* Capybara
  - [Capybara Github](https://github.com/jnicklas/capybara)
  - [Capybara Cheat Sheet](https://gist.github.com/zhengjia/428105)
* Cucumber
  - [Cucumber.io](https://cucumber.io/)
  - [The training wheels came off](http://aslakhellesoy.com/post/11055981222/the-training-wheels-came-off) - Article on why not to use `web_steps.rb` and how to follow best BDD practices
* Haml
  - [Haml Reference](http://haml.info/docs/yardoc/file.REFERENCE.html)
  - [Haml Tutorial](http://haml.info/tutorial.html)
* [Locu Venue Search API](https://dev.locu.com/documentation/#venue-search-api)
* MVC
  - [Wikipedia](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
* Rails
  - [Ruby on Rails - Framework](http://www.tutorialspoint.com/ruby-on-rails/rails-framework.htm) - Brief intro to MVC and Rails
  - [Ruby on Rails Guides](http://guides.rubyonrails.org/index.html)
    * [Active Support Core Extensions](http://edgeguides.rubyonrails.org/active_support_core_extensions.html) - Learning these extensions will save you a lot of time
* RSpec
  - [Better Specs](http://betterspecs.org/) - RSpec best practices
  - [Controller Specs Reference](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs)
  - [RSpec Mocks](https://www.relishapp.com/rspec/rspec-mocks/docs) - A guide on mocking objects in RSpec (very useful when testing views & controllers)
* Other resources
  - [Factory Girl](https://github.com/thoughtbot/factory_girl) / [Rails](https://github.com/thoughtbot/factory_girl_rails) - Useful tool for building and persisting models for testing
  - [Pry](http://pryrepl.org/) - A very useful tool for debugging
  - [VCR](https://github.com/vcr/vcr/) - Web caching
