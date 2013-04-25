title: Open up rubygems.org from Vim

~

One thing I find my self doing a couple of times every week is browsing a `Gemfile` for a project and wanting to checkout the [rubygems.org](http://rubygems.org) page for a gem. Sometimes I want to see what versions are available, the docs or checkout the project on GitHub.

A couple of months back I decided to write a little Vim plugin to save myself a couple of key strokes the next time I want to open up a gems page. 

Here is a demo:

<iframe src="http://player.vimeo.com/video/64759071" width="100%" height="420" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

The plugin adds a command to Vim called `:Gem`. The command basically takes the current word under the cursor and assumes it is a gem name and opens up `http://rubygems.org/gems/<GEMNAME>` in the browser. Currently it only works on Mac OS X as it uses the `open` shell command. 

Pretty simple stuff, but it does the job for me.

Installation instructions and the minimal Vim script code is available on GitHub at [github.com/arvida/vim-open-rubygems](https://github.com/arvida/vim-open-rubygems).