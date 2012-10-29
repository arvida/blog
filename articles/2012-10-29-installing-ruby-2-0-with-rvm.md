title: How to install Ruby 2.0 (ruby-head) with RVM

~

I got a bit excited when I read about the [Ruby 2.0.0 'Feature Freeze'](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/46258?utm_source=rubyweekly&utm_medium=email) and wanted to give ruby 2.0 a test.

This is what I did to get it installed on Mac OS X 10.8.2 with [RVM](http://rvm.beginrescueend.com/) (and [Homebrew](http://mxcl.github.com/homebrew/)).

<% highlight :shell do %>
$ brew install autoconf
$ brew install automake
$ brew install libyaml

$ rvm install ruby-head
<% end %>

To use it you just have to tell RVM to use it:

<% highlight :shell do %>
$ rvm use ruby-head
$ ruby --version
ruby 2.0.0dev (2012-10-12 trunk 37163) [x86_64-darwin12.2.0]
<% end %>

When it is installed you can for example test out named arguments:

<% highlight :ruby do %>
# named_arguments.rb
def hello(name: 'world')
  puts "hello #{name}"
end

hello name: 'boss'
<% end %>
<br>
<% highlight :shell do %>
$ ruby named_arguments.rb
hello boss
<% end %>

## Read more about Ruby 2.0

* [Ruby 2.0 feature list](https://bugs.ruby-lang.org/projects/ruby-trunk/roadmap#2.0.0)
* [Things to Look
Forward to in Ruby 2.0](http://kresimirbojcic.com/2012/08/23/things-to-look-forward-to-in-ruby-2-dot-0.html)
* [PROTECTED METHODS AND RUBY 2.0](http://tenderlovemaking.com/2012/09/07/protected-methods-and-ruby-2-0.html)
* [Why You Should Be Excited About Garbage Collection in Ruby 2.0](http://patshaughnessy.net/2012/3/23/why-you-should-be-excited-about-garbage-collection-in-ruby-2-0)