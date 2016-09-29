---
title: Debug logging on Heroku Cedar with Rails 3.2
---

Recently we where experiencing some weird issues with a Rails 3.2 app that we are hosting on [Heroku Cedar](http://heroku.com) and thought it would be good to enable debug logging in the staging environment. I tried to set the log level to `DEBUG` using [the instructions on Heroku Dev Center](http://devcenter.heroku.com/articles/logging#logging_in_rails), but no debug messages showed up in the logs. 

I ended up checking out the code for the Rails plugin ([rails_log_stdout](https://github.com/ddollar/rails_log_stdout)) that Heroku installs into your app during deployment for setting up logging. It basically just sets `Rails.logger` to [standard output](http://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29) and uses a environment variable called `LOG_LEVEL` to set the log level. I tried a few different things and __ended up copying [the line that sets logger to STDOUT](https://github.com/ddollar/rails_log_stdout/blob/master/init.rb#L6) from the plugin to our applications config for the staging environment__ and that did the trick. After that was deployed our debug messages started showing up in the logs. Happy times.

Our `config/environments/staging.rb` looks something like this now:

{% highlight ruby %}
MyApp::Application.configure do
  # Enable logging on Heroku
  config.logger = Logger.new(STDOUT)

  # rest of config removed ..
end
{% endhighlight %}

_I was checking the forks of `rails_log_stdout` and noticed that [it looks like Heroku](https://github.com/heroku/rails_log_stdout) is working on a new gemified version of the plugin, so hopefully this will start to work like expected soon._
