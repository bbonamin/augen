# Augen

** WARNING: This gem is currently under heavy development, and therefore doesn't really do much yet (if anything). Once 1.0 it's ready, this line in the README will be removed **
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'augen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install augen

## Usage

- To build a Augen::Task, you need to give it:
  - A type (Enum of AST or AAT)
  - Two or more Augen::TaskPoint instances (each is composed of a Augen::Turnpoint(line in a CUP file, check Google Drive), a turnpoint type, and radius)
  - If AAT, minimum time (start open time, close time, max speed, max height, etc will come later)

TODO: Add command line details to how to give these details, via a single CLI command (possibly too hard now), or "highline" style command and response (multiple line inputs)

For AAT tasks, Augen will calculate the nominal, minimum and maximum distance of the task. For AST, only the nominal

Then, tell Augen which scoring ruleset to use to calculate the scoring (similar to the "SeeYou" scripts), Augen shall include some sane default (maybe use official FAI scoring rules by default?)

Finally, tell Augen to choose a task, and feed it one or more IGC files. Augen will spit a human (or machine, command separated?) readable output with each Pilot details, total distance, total time, and scoring.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bbonamin/augen.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
