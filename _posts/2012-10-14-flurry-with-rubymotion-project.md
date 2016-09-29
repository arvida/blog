---
title: "Using Flurry analytics with a RubyMotion app"
---

[Flurry](http://www.flurry.com/) is a service for collecting usage data about your iOS apps. It is a pretty sweet service for getting some insight into how much and where your apps are used, a bit like [Google Analytics](http://www.google.com/analytics/) but for iOS apps. It is very easy to get it to work with a [RubyMotion](http://www.rubymotion.com/) project but can be bit confusing if you haven't added Obj-C libraries to your projects before.

It looks to be a quite a few services like Flurry. I started to use it because it was one of the top google results when I searched for iOS app analytics and it turned out to be really easy to add. It is also free and I get the stats I was looking for.

## The process

First signup for Flurry and add a new “iPhone application”. This will result in a application key and a link for downloading their SDK. Save the application key and download the Flurry SDK.

Copy the `Flurry` folder from the downloaded `Flurry iPhone SDK vx.x.x` folder (it contains two files `Flurry.h` and `libFlurry.a`) to the `vendor` folder in your RubyMotion project. If you don't have a folder named `vendor` in your project create it first.

Then open up your projects `Rakefile` and add the following within the setup block:

{% highlight ruby %}
app.vendor_project('vendor/Flurry', :static)
{% endhighlight %}

Next edit your `app_delegate.rb` and add a call to `Flurry.startSession` in the `#application` method with your application key as argument. It should look something like this:

{% highlight ruby %}
def application(application, didFinishLaunchingWithOptions:launchOptions)

  ...

  Flurry.startSession "YOUR-APPLICATION-KEY"
  true
end
{% endhighlight %}

.. and it is done! <img src="http://www.emoji-cheat-sheet.com/graphics/emojis/beers.png" height="24" width="24" valign="middle">

It usually takes a couple of hours for the stats on Flurry to update.

