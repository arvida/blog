---
title: "My holiday hack: TimeCamper"
---

## Background

When going on holiday around christmas I usually have some small project that I feel I haven't had that much time to work on and decides that I am going to try to finish that during the holiday. Most of the time I do some hacking and end up with some half working code that I forget about. This time I think I managed to finish something (at least a beta). 

I recently read Steven Pressfield's [Do the work](http://www.amazon.com/Do-the-Work-ebook/dp/B004PGO25O), a book about finishing projects. It is written as a hand book when working on a project and is very inspirational. It makes you think about how you are going to get things done and how to avoid not finishing your current project. 

With the ideas from Do the work in mind I decided to finally make something out of a idea I have been toying around with for a while: a menu based Mac OS X app for tracking and reporting time to the [time tracking functionality in 37signals Basecamp](http://basecamphq.com/tour/deliver#/deliver). At [Oktavilla](http://oktavilla.se) we have been using this Basecamp feature a lot when working on client projects and it works great when the time has been reported but I haven't really found any tools for reporting time that fit the way I work and I always end up having to back log time for different reasons. There are probably a great app for this out there that I have missed.

### Key features

I sat down and decided the three most important features for me:

1. I want to be able to report time without having to use the mouse, it should just be few key presses to start and stop tracking time and submitting it
2. Auto-completion on the task description
3. Subtle presence; it stays out of the way when your are not interacting with it and it should be very fast and easy to access when desired

## The result

The idea was pretty simple but as I am no Objective-C programmer and not that familiar with Cocoa it's been taking some time. 

The result is a app called [TimeCamper](http://timecamper.com/). It's still very much in beta but I've been using it in my day to day work since getting back after the holidays and it does the job for me. 

<div style="text-align:center;"><img src="http://www.timecamper.com/graphics/screenshot.png"></div>

I implemented the key features like this:

1. The main form elements are accessible with the tab and space keys
2. Submitted descriptions are saved and they will pop up as suggestions as you start to type a new description
3. Assignable hotkey for triggering focus and visibility of the window

If TimeCamper sounds like something useful for you, check it out at [timecamper.com](http://timecamper.com). And feel free to [submit feedback and bug reports](mailto:arvid.andersson@gmail.com).

### Getting to know Objective-C

It's been interesting to get learn Objective-C and Cocoa more in depth, I think it's a very enjoyable combo to work with. Apple has some great documentation, there are loads of libraries out there to speed up development like [RestKit](http://restkit.org), [Sparkle](http://sparkle.andymatuschak.org/) and [HAKeychain](https://github.com/precipice/HAKeychain). Also named arguments are really nice and there are a lot of sweet built in utilities like NSObject's <a href="http://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/nsobject_Class/Reference/Reference.html#//apple_ref/occ/instm/NSObject/performSelector:withObject:afterDelay:"><code>performSelector:withObject:afterDelay:</code></a> that let's you invoke a method on a object after a delay.

There is [a good blog post by Chris Hulbert](http://splinter.com.au/in-defence-of-objective-c) explaining some of the things you might react to when starting to look into Objective-C.
