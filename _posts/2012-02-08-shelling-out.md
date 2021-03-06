---
title: "Using the shell for fun and profit"
---

A few basic shortcuts and commands I have picked up over the years that have helped me become more efficient when working in a *nix shell. 

_The shortcuts and commands in this post should work with both [bash](http://www.gnu.org/software/bash/bash.html) and [zsh](http://www.zsh.org/)._

## Moving

	CTRL-a

Move to the beginning of line.

	CTRL-e

Move to the end of line.

## Searching

	CTRL-r

This will let you search through the history of commands you have entered. The phrase you search for doesn't have to be in beginning of the command your looking for, so you can search for commands by entering arguments or filenames. If the first match you get is not the command your looking for just hit CTRL-r again and will move to the previous match.

This is very useful if you do a lot of logging in and out of servers by SSH; just hit `CTRL-r`, start typing a part of the hostname or username, hit `ENTER` and bang - you're connecting to the server. 

## Backgrounding

	CTRL-z

This will bring the current application running in the shell to the background. To bring back the backgrounded application use the command `fg`. 

I use this a lot when I am working in vim and need to do a few shell commands, much faster than splitting the window or opening up a new tab.

## Repeating

	$ !!

Use the `!!` command to repeat the last command you ran, just like doing `up-arrow + enter` on the keyboard.

I am using this by binding `!!\n` to a convenient key combination so I don't have to move over the arrow keys to repeat the last command. You can easily create key combinations for stuff like this in [iTerm2](http://www.iterm2.com/) by opening Preferences > Profiles > Keys and adding a shortcut with action set to ”Send Text” and ”!!\n".

	$ !ssh

This will repeat the most recent command you entered that started with ”ssh”.

_If you are using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) this won't work by default, to enable you have to remove the line that says `setopt hist_verify` in `~/.oh-my-zsh/lib/history.zsh`._

## Chaining

	$ a-long-running-command && command-depending-on-the-first-one

Your can chain commands by putting them on the same line and using either `;` or `&&` to separate them. The problem with `;` is that it will run all the commands  no matter what happens and the great thing with `&&` is that it will stop if one of the commands fail. 

This is really useful when you are working with tasks that will take some time to finish and is dependent of each others success. To illustrate:
	
	$ mkdir hello
	$ mkdir hello && echo "I created hello"    
	mkdir: hello: File exists
	$

## Opening

	$ open .
	$ open image.jpg

On Mac OS X there is a command called `open`, you can use this to open up a directory or a file like it would have happened if you had double clicked on it in the Finder.

# Notes

Most of the shortcuts in the shell are made possible by the great [GNU Readline Library](http://tiswww.case.edu/php/chet/readline/rltop.html), this library is used in many other shell applications which makes the shortcuts available in those as well.

There are of course loads of more short cuts and useful commands to learn. Bash has been around for over 20 years so there has been a few people documenting the features. For example [Wikipedia](http://en.wikipedia.org/wiki/Bash_\(Unix_shell\)#Keyboard_shortcuts) is pretty good starting point for the different keyboard short cuts available in bash.

If you are a Vim user you will probably like [vi mode](http://www.hypexr.org/bash_tutorial.php#vi) for your shell. With this you can use the commands you know from vim to edit the command line.
