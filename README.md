# FileBasedHealthcheck

A gem to use a healthcheck for readiness and liveness probes in Kubernetes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'file-based-healthcheck'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install file-based-healthcheck

## Usage

The idea behind this gem is to register heartbeats using a file. Thanks to that and comparing when the last heartbeat, happened you can easily check if the process is running or not.

Initialize a new healthcheck:

``` rb
healthcheck = FileBasedHealthcheck.new(directory: Rails.root.join("tmp"), filename: ENV.fetch("HOSTNAME"), time_threshold: 60)
```

Register a heartbeat:

``` rb
healthcheck.touch
```

To verify if the process is running:

``` rb
healthcheck.running?
```

This method is going to return `true` if the file (based on `filename`) was touched in the last `time_threshold` in seconds.

To remove file:

``` rb
healthcheck.remove
```

It is recommended to implement some sort of wrapper for your processes and use this gem under the hood. Then, you could create a following binary:

``` rb
#!/usr/bin/env ruby

require "bundler/setup"
require_relative "../lib/my_process"

result = MyProcess::HealthCheck.check
if result.success?
  exit 0
else
  MyProcess.logger.fatal "[MyProcess] health check failed: #{result.message}"
  exit 1
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/file-based-healthcheck.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
