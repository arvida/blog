title: Setting Rails ActiveRecord connection encoding to UTF-8 on Heroku

~
<a href="#tldr">The tl;dr ☞</a>

<b>The problem:</b> When a Rails app is deployed to <a href="http://www.heroku.com/">Heroku</a>
a ERB file called <code>database.yml</code> is added to the app's config directory.
This ERB file generates the YAML needed for ActiveRecord to make the DB connection based on
a Heroku config variable called <code>DATABASE_URL</code>. You might recognize this variable
from when you run <code>heroku config</code> and it is basically a url with settings for the 
DB connection. <em>Unfortunately utf-8 encoding is not added to the generated YAML by default.</em>

This is what config/database.yml looks like on Heroku (on the Cedar stack):

{% highlight erb %}
<%

require 'cgi'
require 'uri'

begin
  uri = URI.parse(ENV["DATABASE_URL"])
rescue URI::InvalidURIError
  raise "Invalid DATABASE_URL"
end

raise "No RACK_ENV or RAILS_ENV found" unless ENV["RAILS_ENV"] || ENV["RACK_ENV"]

def attribute(name, value)
  value ? "\#{name}: \#{value}" : ""
end

adapter = uri.scheme
adapter = "postgresql" if adapter == "postgres"

database = (uri.path || "").split("/")[1]

username = uri.user
password = uri.password

host = uri.host
port = uri.port

params = CGI.parse(uri.query || "")

%>

<%= ENV["RAILS_ENV"] || ENV["RACK_ENV"] %>:
  <%= attribute "adapter",  adapter %>
  <%= attribute "database", database %>
  <%= attribute "username", username %>
  <%= attribute "password", password %>
  <%= attribute "host",     host %>
  <%= attribute "port",     port %>

<% params.each do |key, value| %>
  <%= key %>: <%= value.first %>
<% end %>
{% endhighlight %}

<b>A solution:</b> If we read through the code we see that we can add additional attributes to the generated YAML by
adding a query string to the url. Sweet!

<span id="tldr">All we have to do is update the <code>DATABASE_URL</code> config variable with our encoding settings:</a>

{% highlight text %}
$ heroku config:add DATABASE_URL="mysql2://user:pass@abc.rds.amazonaws.com/my-db?encoding=utf8&collation=utf8_general_ci" 
{% endhighlight %}

It's pretty clever of Heroku to use DATBASE_URL like this!
