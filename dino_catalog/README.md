## Dinosaur Catalog

We need to catalog some dinosaurs for my newest project, DinoDex. We've got a [CSV](http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html) file for the dinosaur facts, and we need the code to read all the dinosaur facts and do some basic manipulations with the data.

### Requirements

Go check out the CSVs and come back. We've just got a few features that we need:

1. We have two CSVs with information about dinosaurs.  They are formatted differently, and we need to support both formats.
2. The DinoDex should be able to find some basic information:
    * Fetch all the dinosaurs that were bipeds.
    * Fetch all the dinosaurs that were carnivores (fish and insects count).
    * Fetch dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous).
    * Fetch only big (> 2 tons) or small dinosaurs.
    * Filter calls should be chainable.
3. For a given dinosaur, we'd like to be able to print all the known facts about that dinosaur. If there are facts missing, don't print empty values, just skip that heading. Make sure to print Early / Late etc for the periods.
4. The DinoDex should be able to print all the dinosaurs in a given collection (after filtering, etc).

#### Extra Credit

1. Allow a generic search by parameters (pass in hash, return all dinos with matching parameters).  This search should also be chainable.
2. Export dinos to JSON.

## Note

You should write both the tests and the code for this exercise.  Writing lots of code is the best way to get better.

Presently the Enova SE testing suite includes [RSpec](http://rspec.info/) and [Cucumber](http://cucumber.io/). For this exercise please implement your tests using RSpec. You will have a chance to use Cucumber in subsequent tasks.

Incidentally, if you feel there are testing tools other than RSpec that might be more beneficial for the team, please let us know! Feel free to show off your skills and implement an additional set of tests for this exercise using those tools.
