---
title: How to install Ruby 1.9.3rc1 with RVM
---

Today Ruby 1.9.3 RC1 was [released](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/388203), 
it's a faster version of ruby with a couple of new features. Peter Cooper has written 
a nice summary about the new stuff in ruby 1.9.3 [over at RubyInside](http://www.rubyinside.com/ruby-1-9-3-introduction-and-changes-5428.html).

[Ruby Version Manager](http://beginrescueend.com/) hasn't added RC1 to it's known rubies yet, but 
you can still install it by specifying the tag [v1_9_3_rc1](https://github.com/ruby/ruby/tree/v1_9_3_rc1) to the rvm install command:

{% highlight text %}
  ~ $ rvm install 1.9.3-tv1_9_3_rc1
{% endhighlight %}

After finishing the install it's pretty nice to add a more rememberable alias for RC1:

{% highlight text %}
 ~ $ rvm alias create ruby-1.9.3-rc1 ruby-1.9.3-tv1_9_3_rc1
 ~ $ rvm use ruby-1.9.3-rc1
{% endhighlight %}

Also if you have a lot of gems, you can copy them with [RVM's copy and migrate commands](http://beginrescueend.com/rubies/upgrading/).
