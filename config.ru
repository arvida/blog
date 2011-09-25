require 'serious'
Serious.set :title, 'waiworinao ★ random notes by arvid andersson'
Serious.set :author, 'Arvid Andersson'
Serious.set :url, 'http://blog.arvidandersson.se'
Serious.set :public, File.join(Dir.getwd, 'public')
Serious.set :views, File.join(Dir.getwd, 'views')
Serious.set :cache_timeout, 3600
Serious.set :google_analytics, 'UA-20637790-3'
run Serious
