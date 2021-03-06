---
title: Some stats from Emoji-cheat-sheet.com
---

Since I put [Emoji-cheat-sheet.com](http://www.webpagefx.com/tools/emoji-cheat-sheet) online on October 16th it has had 2259 unique visitors, 4095 page views and people spend about 5 minutes in average on the page. Most of the visitors come from the US, UK, Sweden, Canada and Germany. The source for the page is [available on GitHub](https://github.com/arvida/emoji-cheat-sheet.com) and I have had [two patches](https://github.com/arvida/emoji-cheat-sheet.com/network) submitted. Both the guys at [GitHub](http://github.com/) and [37signals](http://37signals.com/) seem to have noticed the site. 

## Click stats

After the site had been online a few days I added click tracking on the emoji's and Campfire sounds to be able to see which one's people click the most. Got no real use for the stats it's just for fun.

### Emojis

| Placement  | Emoji       |    | Clicks |
|:----------:|:-----------:|:--:|:------:|
|1			 |:+1: |<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/plus1.png" width="22" height="22" align="middle">		   |89
|2			 |:-1:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/-1.png" width="22" height="22" align="middle">		   		   |39
|3			 |:clap:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/clap.png" width="22" height="22" align="middle">		   	   |32
|4			 |:beer:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/beer.png" width="22" height="22" align="middle">		   	   |31
|5			 |:sparkles:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/sparkles.png" width="22" height="22" align="middle">		      |26
|6			 |:warning:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/warning.png" width="22" height="22" align="middle">		   	   |26
|7			 |:hankey:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/hankey.png" width="22" height="22" align="middle">		   	   |25
|8			 |:koala:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/koala.png" width="22" height="22" align="middle">		   	   |24
|9	  		 |:thumbsup:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/thumbsup.png" width="22" height="22" align="middle">		      |24
|10  	     |:nail_care:|<img src="http://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/nail_care.png" width="22" height="22" align="middle">		     |23

### Sounds

| Placement  | Emoji       | Clicks |
|:----------:|:-----------:|:------:|
|1	|/play pushit|	 89
|2	|/play tmyk|	 59
|3	|/play yeah|	 50
|4	|/play greatjob|	 49
|5	|/play live|	 45
|6	|/play drama|	 43
|7	|/play trombone|	 43
|8	|/play vuvuzela|	 38
|9	|/play rimshot|	 32
|10 |/play crickets|	 27	

I guess you can interpret these stats in a lot of different ways. The campfire sounds looks to be less easy to remember or more popular then the actual emojis. I think it is pretty sweet that :koala: and :nail_care: are so popular, I wouldn't have guessed that those would make it to the top ten.

### Tracking clicks

It is very to easy to add click tracking (or for any other event tracking) to your site if your are using [Google Analytics](http://www.google.com/analytics/). It is basically just a bit of JavaScript that you trigger when a event you want to track take place:

{% highlight javascript %}
$('.my-links').click(function() { 
  _gaq.push(['_trackEvent', 'My-Links', 'Clicked', this.href]);
});
{% endhighlight %}
