---
title: Significance of the HTTP Date header
---

I have been doing some work over the last week that involves serving files with ActionController's [#send_file](http://api.rubyonrails.org/classes/ActionController/DataStreaming.html#method-i-send_file) method. One problem I stumbled upon was that my <code>Cache-Control</code> headers didn't get respected and I was getting <code>X-Cache: Miss from cloudfront</code> repeatedly when doing requests through [CloudFront](http://aws.amazon.com/cloudfront).

It turn's out that the problem is that <code>#send_file</code> doesn't include a Date HTTP header when creating the HTTP response headers. **The Date header is used to tell the client  at what time the response was generated and it is this value that the client uses when calculating how long the local cache of the response is going to be valid.** If it is not included the clients browser will not cache the response according to the <code>Cache-Control</code> header and CloudFront won't know how long to save the file.

It's easy to fix, just add a Date header to the response  where you use #send_file. For example:

{% highlight ruby %}
expires_in 1.year, public: true
response.header['Date'] = Time.now.httpdate
send_file file.path, filename: file.name, type: file.mime_type
{% endhighlight %}

It is important that your use <code>#httpdate</code> when setting the date header so the returned string can be understod by the client.

You can read more about the Date header in [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html).

### UPDATE - October 30th 2011

After a bit of research I found that this issue looks to be [related to that I am using passenger and nginx](http://code.google.com/p/phusion-passenger/issues/detail?id=485) in the project where I noticed the missing Date header. I looks like the passenger guys agrees that this is an issue and plans to fix it.

This issue is kind of interesting; for example [unicorn](http://unicorn.bogomips.org/) sets the Date header and [thin](http://code.macournoyer.com/thin/) doesn't. 
*It raises the question: **What part of the stack is responsible for setting what response header?*** 

The answer is pretty easy for most of the response headers but with Date I am not so sure. If I use <code>expires_in</code> in my Rails app I expect that the Date header is set but if I just do a plain <code>response['Cache-Control'] = "public, max-age=3600"</code> in a [Sinatra](http://www.sinatrarb.com/) app I am not sure if Sinatra should be responsible for the Date header. Maybe it should be the front webserver that ensures that the Date header is always set? I guess some more research is needed.

### UPDATE - November 12th 2011

I did a patch for Rails last week that ensures that the Date header is sent when you use <code>expires_in</code>. You can check out [the pull request over at github](https://github.com/rails/rails/pull/3479).  

If you got any comments or thoughts on this issue, let me know as I think it's quite a interesting topic and would like to hear what other people think of this. 

### UPDATE - February 18th 2012

The patch was accepted and merged today. Yay! 
