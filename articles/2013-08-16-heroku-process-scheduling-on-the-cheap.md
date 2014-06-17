title: Heroku process scheduling on the cheap

~

Most web apps have different highs and lows of traffic during the day. Maybe you get most of your traffic during daytime and not so much during the night and early morning. If you have this kind of situation it can be a good idea to adjust your number of dynos according to the changes in traffic in order to save a few bucks. When this is done automatic it is sometimes called auto-scaling or process scheduling. 

There are [a few services](https://addons.heroku.com/process-scheduler) that can do this for you. However it is pretty easy to setup by your self, just using Heroku and some ruby code. And it can be for free. 


## Background

* Each Heroku app gets [750 dyno-hours for free](https://devcenter.heroku.com/articles/usage-and-billing#750-free-dyno-hours-per-app) each month. 
* Heroku offers a free cron-like add-on called [Heroku Scheduler](https://addons.heroku.com/scheduler) for running periodical tasks.
* With the [Heroku API](https://devcenter.heroku.com/articles/platform-api-reference) we easily can scale the number of dynos for our apps.

## Putting it together

### The scaling utility app

Create a new ruby project with a Gemfile:

<% highlight :ruby do %>
source "https://rubygems.org"

ruby "2.0.0"

gem "heroku-api"
<% end %>

Create a ruby file “scaler.rb” that handles the API interactions:

<% highlight :ruby do %>
#!/usr/bin/env ruby

require "bundler"
require "optparse"

Bundler.require(:default)

heroku_api_key = ENV["HEROKU_API_KEY"] || raise("No Heroku API key env variable set")

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{ARGV[0]} [options]"
  opts.on("-a", "--app NAME") { |v| options[:app] = v }
  opts.on("-t", "--type DYNO_TYPE") { |v| options[:type] = v }
  opts.on("-d", "--dynos NO_DYNOS") { |v| options[:count] = v }
end.parse!

raise OptionParser::MissingArgument, "--app" if options[:app].nil?
raise OptionParser::MissingArgument, "--type" if options[:type].nil?
raise OptionParser::MissingArgument, "--dynos" if options[:count].nil?

heroku = Heroku::API.new(api_key: heroku_api_key)
heroku.post_ps_scale options[:app], options[:type], options[:count]
<% end %>

### Deploying

Create a new Heroku app and push the code:

<% highlight :shell do %>
$ heroku apps:create my-auto-scaler
$ git push heroku master
<% end %>

Setup your Heroku API key as environment variable, you find this on [your account page](https://dashboard.heroku.com/account):

<% highlight :shell do %>
$ heroku config:set HEROKU_API_KEY=my-api-key
<% end %>

Add the Heroku Scheduler add-on:

<% highlight :shell do %>
$ heroku addons:add scheduler:standard
<% end %>

Open up the schedulers setting page:

<% highlight :shell do %>
$ heroku addons:open scheduler:standard
<% end %>

Set up jobs for when your want to scale your app. 

For example if you create a job with the task:

<% highlight :shell do %>
ruby scaler.rb -a my-app -t web -d 3
<% end %>

.. and set the next run to 5:00 UTC. The number of web dynos for the app “my-app” will be scaled to 3 at 5:00 in the morning UTC.

## A little advice

If you are planning on doing this on a production app make sure you got some error tracking to get alerted if the scheduled tasks has failed to run. It is mentioned in [the docs](https://devcenter.heroku.com/articles/scheduler) that “Scheduler is known to occasionally (but rarely) miss the execution of scheduled jobs”. For example I added [e-mail alerts and logging to StatHat](https://github.com/arvida/thief-in-the-night). 
