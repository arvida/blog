---
title: "Do the asset serving dance on Heroku Cedar with Rails 3.1 and CloudFront"
---

The <a href="http://guides.rubyonrails.org/asset_pipeline.html">asset pipeline in Rails 3.1</a> 
and <a href="http://devcenter.heroku.com/articles/cedar">Heroku's Cedar stack</a> adds a few new 
things to think about when serving static assets from your apps. Heroku has removed 
<a href="https://www.varnish-cache.org/">Varnish</a> and <a href="http://nginx.org/">nginx</a> from 
the the cedar stack which means that static files served from a app won't get cached or gzipped automagically. 
One way to go is to use Amazon's S3 as asset host together with the 
<a href="https://github.com/rumblelabs/asset_sync">asset_sync</a> gem. However there are <a href="http://stackoverflow.com/questions/7430578/how-to-universally-skip-database-touches-when-precompiling-assets-on-heroku">a few</a> <a href="https://github.com/rumblelabs/asset_sync/issues/5#issuecomment-2049722">problems</a> 
that can occur when Heroku run <code>rake&nbsp;assets:precompile</code> during the deploy process. 

With these facts you might realize that you want to put your compiled assets on a content delivery 
network like Amazon's <a href="http://aws.amazon.com/cloudfront/">CloudFront</a> so the assets can be served 
fast and your dynos don't have to be bothered with serving and compiling assets. 

<h2>How do we solve this in a good way?</h2>

First create a new CloudFront distribution. A great thing with CloudFront is that you can set any
domain as the source for the distribution. You do this for your Heroku hosted app by specifying 
the apps domain as the ”Custom Origin” when creating a new distribution. With this set CloudFront
don't need a S3 bucket, instead it will mirror the assets from the custom origin 
domain. When the distribution gets a request for a file that it don't have mirrored yet it will just
issue the same request to your app, cache the result and return it. This also makes it possible to 
serve gzipped versions of your assets as CloudFront forwards the clients request headers and rack 
can serve gzipped versions of your assets if the client supports it 
(<a href="#ggg-zippd">more on this further down</a>).

Add the new distribution's domain name (or CNAME if you specifed one) as the the asset host for your app in 
production environment:

{% highlight ruby %}
# config/environments/production.rb
..
config.action_controller.asset_host = "http://aabbccdd.cloudfront.net"
..
{% endhighlight %}

This will make rails add the specified asset host to the generated url when you use <code>stylesheet_link_tag</code> 
or similair helpers in production. For example if you do

{% highlight erb %}
<%= stylesheet_link_tag 'application' %>
{% endhighlight %}
you will get
{% highlight text %}
<link href="http://aabbccdd.cloudfront.net/assets/application-388a2a900c29a176d20c18ed000f77fa.css" media="screen" rel="stylesheet" type="text/css" />
{% endhighlight %}

Great, but we are not quite done yet because Heroku will automatically run the rake task to compile
the assets when your app is deployed. This is a problem because if the files that CloudFront requests
exists on disk then they will not be served from your rails app but from the disk, so we won't get the correct
<a href="https://github.com/sstephenson/sprockets/blob/master/lib/sprockets/server.rb#L203">cache headers</a>
and we won't be able to serve gzipped versions of the assets.

<h2>What we need to do</h2>

<h3>1. Disable the assets precompile rake task</h3>
There is two ways to do this. By overriding the <code>assets:precompile</code>
rake task:
{% highlight ruby %}
# lib/tasks/disable_assets_precompile.rake
Rake::Task['assets:precompile'].clear
namespace :assets do
  task :precompile do
    puts '* rake assets:precompile has been disabled (lib/tasks/disable_precompile.rake)'
  end
end
{% endhighlight %}

You can also add a empty file called <code>public/assets/manifest.yml</code> to your project, 
if Heroku detects this file it will not run the <code>assets:precompile</code> task on deploy.
Both these ways are kind if hackish, so choose the one that suits you best.

<h3>2. Enable on-the-fly asset compiling in production</h3>
As we now need to serve the assets through the rails stack
when CloudFront makes it's first requests we need to enable asset compiling in the production environment, 
this is done by setting <code>config.assets.compile</code> to <code>true</code> in your production settings:
{% highlight ruby %}
# config/environments/production.rb
..
config.assets.compile = true
..
{% endhighlight %}

<h3 id="ggg-zippd">3. Enable serving of gzipped content</h3>
As Heroku has removed nginx from the cedar stack we have to do the gzipping by ourselves, this is done 
by adding a rack middleware called 
<a href="https://github.com/chneukirchen/rack/blob/master/lib/rack/deflater.rb">Rack::Deflater</a>.
It's part of <a href="https://github.com/chneukirchen/rack">Rack core</a> so it's really easy to add,
just update your <code>config.ru</code> file in the root of your rails project to look like this:
{% highlight ruby %}
require ::File.expand_path('../config/environment',  __FILE__)
use Rack::Deflater
run MySuperApp::Application
{% endhighlight %}

<b>Done</b>, deploy your app and celebrate with beer. With this setup you get a geo-aware, fast and 
cachable way to serve your Rails 3.1 assets.

<em>Thanks to <a href="https://twitter.com/#!/joeljunstrom">@joeljunstrom</a> for the proofreading!</em>
