
---
title: Screen intro
---

Lately I have grown to like the `screen` command a lot. It is described as a terminal multiplexer, which means that it allows you to create several shell sessions within one shell session. Similair to doing multiple splits or tabs in a terminal application like [iTerm2](http://www.iterm2.com/). 

_“Screen  is  a  full-screen  window manager that multiplexes a physical terminal between several processes”_ From the man page of screen

These days most people use [tmux](http://tmux.sourceforge.net/) for this functionality. It is a modern alternative to screen. The thing with screen is that it will be available on most UNIX-like computers you SSH into by default. Which makes it a pretty sweet tool to know if you do any kind of maintinance on servers over SSH. For example I can keep a tail of log file open and edit a configuration file in another session with just one SSH connection opened. 

![Example scren session](https://dl.dropbox.com/s/790973rtp1fuk64/screen.png)

## Starting screen

Just type `screen` into the command line.

	$ screen
	
This will first display some license info. Hit space (or the return key) and you will be presented with a new shell that works just like your regular shell except that is run by screen which allows us to some cool stuff. Screen offers a bunch of commands to control the current shell. The screen commands are invoked by typing CTRL-a followed by a another character, for example `CTRL-a c` creates a new window. 

Check out [the man page](http://manpages.ubuntu.com/manpages/precise/en/man1/screen.1.html) on screen for info on all commands you can do within screen. 

## Creating a horizontal split

First split the current display horizontally:

	CTRL - a S

Then switch to the new region:

	CTRL - a TAB

Finally create a new window with a shell in the new region:

	CTRL - a c
	
## Delete a split region

Move to the region you want to delete by:

	CTRL - a TAB
	
Then delete it:

	CTRL - a X
	
## Moving around

To move arround within a screen session you have invoke scroll mode:

	CTRL - a ESC
	
In scroll mode you can use HJKL, the arrow keys or page up / down keys to move around. You can also type `/` to search forward and `?` to search backwards. This mode shares quite a few commands with vim. For example you can do `gg` and `GG` to move to begining / end of file and `w` and `b` to move to next / previous word.

Exit scroll mode by hitting the ESC key.

## Switching between windows

To switch to the next window:

	CTRL - a n
	
To switch to the previous window:

	CTRL - a p
	
You also switch by listing a available windows and selecting a window:

	CTRL - a "

## Exiting 

Quit all running sessions by issuing `CTRL - a` and then type `:quit`. You can also just exit all the running sessions, just invoke the shell's `exit` command in the sessions until the last one is closed. 

The line `[screen is terminating]` is displayed when screen has exited.

## More about screen

There is a old but good intro article on kuro5hin<br>
[http://www.kuro5hin.org/story/2004/3/9/16838/14935](http://www.kuro5hin.org/story/2004/3/9/16838/14935)

The official “Screen User's Manual”<br>
[http://www.gnu.org/software/screen/manual/screen.html](http://www.gnu.org/software/screen/manual/screen.html)
