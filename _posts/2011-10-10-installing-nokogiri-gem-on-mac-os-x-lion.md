---
title: Installing the nokogiri gem on Mac OS X Lion
---

Yesterday I was setting up a new box with Mac OS X Lion at the office. I had installed <a href="http://mxcl.github.com/homebrew/">homebrew</a>, 
<a href="http://beginrescueend.com/">rvm</a> and <a href="http://blog.arvidandersson.se/2011/09/24/install-ruby-193-rc1-with-rvm">ruby 1.9.3rc1</a>
and when I ran <code>bundle</code> in a project folder I got the following error:

{% highlight text %}
...
Installing net-ssh (2.1.4) 
Installing net-scp (1.0.4) 
Installing nokogiri (1.5.0) with native extensions 
Gem::Installer::ExtensionBuildError: ERROR: Failed to build gem native extension.

        /Users/arvid/.rvm/rubies/ruby-1.9.3-rc1/bin/ruby extconf.rb 
extconf.rb:10: Use RbConfig instead of obsolete and deprecated Config.
checking for libxml/parser.h... yes
checking for libxslt/xslt.h... yes
checking for libexslt/exslt.h... yes
checking for iconv_open() in iconv.h... no
checking for iconv_open() in -liconv... no
-----
libiconv is missing.  please visit http://nokogiri.org/tutorials/installing_nokogiri.html for help with installing dependencies.
...
{% endhighlight %}

I checked out <a href="http://nokogiri.org/tutorials/installing_nokogiri.html#mac_os_x">nokogiri's Mac OS X installation instructions</a>.
The instructions didn't work for the above error and I ended up doing the following instead:

{% highlight text %}
~ $ brew install libiconv
==> Downloading http://ftpmirror.gnu.org/libiconv/libiconv-1.14.tar.gz
...
~ $ brew link libiconv
Linking /usr/local/Cellar/libiconv/1.14... 17 symlinks created
{% endhighlight %}

The trick is to do the <code>brew link</code> command, this adds libiconv to the homebrew path so the compiler
can find the lib and header files. After running those homebrew commands the nokogiri installation worked: 

{% highlight text %}
~ $ gem install nokogiri
Building native extensions.  This could take a while...
Successfully installed nokogiri-1.5.0
1 gem installed
{% endhighlight %}
