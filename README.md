# Cronmon

<h3>Welcome Welcome and more Welcome!!!</h3> 

If you are also frustated with more of cron errros and doesn't know when the cron is working or it is stopped with some issue.<br/>
Then you have to right place. You can be relaxed now because cronmon takes care of all your issues with cron and will let you any issue regarding cron instantly. <br/><br/>

###Currently, It supports below functionalities <br/>

- If cron raises an error while it executing. It sends an email with the error message. <br/>
- Every time cron runs, We calculate avg. time execution time of the cron. So, by next time if the cron doesn't complete within avg. time period then it sends an email with a warning that the cron didn't completed within avg. execution time.<br/>



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cronmon'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cronmon

## Usage

- I've tried to make as easy as possible to integrate this gem with your application. But as they say that there can't a perfect solution for any problem.

### To monitor crons via rake task

Add these in your main rake file.
```
Include RakeHooks
add_cron_hooks
```

### To monitor crons via your sidekiq jobs

Add this in your sidekiw worker which you want to monitor.
```
inlcude JobMetrics
```

### Logging data in the DB

- This gems needs two tables. One for cron to store and other for logging of cron to story daily

```
# Table name: crons
#
#  id                  :bigint           not null, primary key
#  average_time_period :float(24)        default(0.0)
#  name                :string(255)
#  scope               :string(255)
#  sidekiq_enabled     :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
 
```

```
# Table name: cron_logs
#
#  id         :bigint           not null, primary key
#  ended_at   :datetime
#  error_log  :string(255)
#  started_at :datetime
#  cron_id    :bigint
#  job_id     :string(255)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cronmon.
