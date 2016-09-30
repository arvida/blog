---
title: Git commit messages as documentation
published: false
---

Code is all about communicating with your computer and tell it what you want it to do. We also use it to tell our colleagues what we want the computer to do. That is why we invented programming languages that are similar to our human languages.

But, code is hard to read and understand. In a large system it is often very difficult to follow the different paths through the code.

## We have different tools to make our code understandable

We write readable code and tests that document the way we expect our code to behave. If we are ambitious, we write comments that can generate documentation.

And then we have git. It is a very common distributed version control and source code management tool. Most people who work with development these days use git for version control.

The thing is that if you use the git the right way it will automatically give us a log that describes our source code. Right down to every single line.

## However we have a problem

Sometimes we don't put that much energy into describing our code changes.

You often see commits with messages like

> fix test

or

> Added some stats to dashboard

or

> :sob:

The problem is when we 6 months later discovers a bug that was introduced in the commit `Added some stats to dashboard` which is 17 changed files with 231 lines added and 29 deleted lines. Then you stare at your screen and wonder what was going through your head when making all these changes.

If we would have just put a little a bit more time on describing the changes the code might have been a bit more easy to understand.

I and many others write commit messages like this sometimes. It is often because of habit, laziness and that you haven't really thought about the great possibilities commit messages gives us.

# How should we think when writing commit messages?

The first step is to divide the work into smaller commits to make it possible to describe the change with a title and a few sentences. If it feels hard to describe the current code changes it is a good sign that is is time to divide the changes into smaller commits.

I have started to try to think of my commit messages as e-mail messages to myself that I will read in a year or so. Each commit message has a subject and a body. If there is a related issue in GitHub I include a reference to that in the commit message.

## The commit message parts

A style that I think works well is this:

### First a subject

* First start with a title or subject, which should be about 70 characters long. Most places where you can see the git commits expect that the topic is around 50 characters. GitHub has a display limit at 70 characters.
* If the commit has something to do with an issue and I will add a reference to the first on the subject
* The subject should be a short summary of the changes commiten done. Technical details can be saved to the content.
* The subject should not end with a period.
* The subject is the part of commiten shown most so it's good to spend time to get it easily understandable and clear.

### Second a blank line

### Third the full description

Here, you write a little further description of the change.

* What is the reason for the change.
* Why has chosen to do in a specific manner.
* Is there anything that can be useful to think about when you look at change, something that is not clear or easy to miss?
* Please use bullet points to make it clear.

# Tempus

There is a saying that one should write the commit messages in the imperative form. That means that you express yourself solicitation, eg the use of "fix" instead of "fixed" or "add" instead of "added".

One can say that there are two strong wins to using imperative.

First, it is so git expresses itself when the automatic commit messages such as "Merge branch 'master' of github.com: example / app". And it is for that describes what changes does when it is applied, not to what it was doing or what is going to happen but this does.
2nd And they decided a tense makes it unnecessary to consider every time.

# Clearance

There is no way that is more right or wrong.

But I have noticed that when I put more time on my commit messages, I have to reflect more on the changes I make in a project. One can imagine an extraordinary time and it increases quality and it becomes small cohesive commits.

It becomes incredibly very pleasant to walk through a git log that actually talks about change and not only that something has happened.

The main thing I think is to realize which fanatically tools git is and how to use the commit messages as a tool to document and understand a project's history.


# Resources

Tim Pope: "A Note About Git Commit Messages"
http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

Guidelines for making patched to Git
http://git.kernel.org/cgit/git/git.git/tree/Documentation/SubmittingPatches
