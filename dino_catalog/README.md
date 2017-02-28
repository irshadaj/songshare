## Dinosaur Catalog

We need to catalog some dinosaurs for my newest project, Dinodex. We've got a [CSV](http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html) file for the dinosaur facts, and we need the code to read all the dinosaur facts and do some basic manipulations with the data.

### The CLI

```text
Usage: cli.rb [options] <file>...

Filters:
    -b, --big                        Include only big dinosaurs
        --bipedal                    Include only bipedal dinosaurs
        --carnivores                 Include only carnivores
    -d, --diet=DIET                  Include only dinosaurs with the given diet
        --herbivores                 Include only herbivores
        --max-weight=WEIGHT          Include only dinosaurs no heavier than WEIGHT
        --min-weight=WEIGHT          Include only dinosaurs no lighter than WEIGHT
    -n, --name=NAME                  Include only dinosaurs whose name contains NAME
    -p, --period=PERIOD              Include only dinosaurs from the given period
    -s, --small                      Include only small dinosaurs

Output options:
    -f, --format=FORMAT              Output results as FORMAT [default: list]
    -o, --output=FILENAME            Output results to file at path FILENAME instead of STDOUT

Miscellaneous options:
    -h, --help                       Show this help message

```

When provided, each flag will set a different hash key/value pair in an options hash.  Take a look at the [parser code](lib/dinodex/cli_parser.rb) and [spec](spec/dinodex/cli_parser_spec.rb) to see specifics.

### Requirements

Go check out the CSVs and come back. We've just got a few features that we need:

1. We have two CSVs with information about dinosaurs.  They are formatted differently, and we need to support both formats.
2. The Dinodex should be able to find some basic information:
    * Fetch all the dinosaurs that were bipeds.
    * Fetch all the dinosaurs that were carnivores (fish and insects count).
    * Fetch dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous).
    * Fetch only big (> 2 tons) or small dinosaurs.
    * Filter calls should be chainable.
3. For a given dinosaur, we'd like to be able to print all the known facts about that dinosaur. If there are facts missing, don't print empty values, just skip that heading. Make sure to print Early / Late etc for the periods.
4. If format is set to `list`, Dinodex should be able to print all the dinosaurs in a given collection (after filtering, etc).
5. If format is set to `json`, Dinodex should output to JSON.
6. If `--output` is set, Dinodex should output results to the provided file.
7. Allow a generic search by parameters (pass in hash, return all dinos with matching parameters).  This search should also be chainable.

## Note

You should write both the tests and the code for this exercise.  Writing lots of code is the best way to get better.

Presently the Enova SE testing suite includes [RSpec](http://rspec.info/) and [Cucumber](http://cucumber.io/). For this exercise please implement your tests using RSpec. You will have a chance to use Cucumber in subsequent tasks.

Incidentally, if you feel there are testing tools other than RSpec that might be more beneficial for the team, please let us know! Feel free to show off your skills and implement an additional set of tests for this exercise using those tools.
