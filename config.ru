require 'rubygems'
require 'bundler'
Bundler.require

Serious.set :title, 'waiworinao ★ random notes by arvid andersson'
Serious.set :author, 'Arvid Andersson'
Serious.set :url, 'http://blog.arvidandersson.se'
Serious.set :public, File.join(Dir.getwd, 'public')
Serious.set :items_on_index, 20
Serious.set :views, File.join(Dir.getwd, 'views')
Serious.set :cache_timeout, 3600*24
Serious.set :google_analytics, 'UA-20637790-3'
Serious.set :disqus, 'blog-arvidandersson'
run Serious
