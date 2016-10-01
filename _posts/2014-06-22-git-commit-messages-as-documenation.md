---
title: Git commit messages as documentation
---

Code is all about communicating with your computer and telling it what you want it to do. To make it easy to pass this knowledge on to our fellow humans we use programming languages that are similar to our human languages.

But, code is hard to read and understand. Even in a small application it is often very difficult to follow the different execution paths through out the code. That is why we need to document the actual code.

## We have tools to make our code understandable

We can focus on writing readable code and tests that document the way we expect our code to behave. If we are ambitious we write comments that can generate documentation.

And then we have git. It is a very common distributed version control and source code management tool. It is very common for people who work with development these days use git for version control.

The thing is that if you use the git the right way it will automatically give us a log that describes and documents our code. Right down to every single line.

## However, we have a problem

Sometimes we don't put that much energy into describing our code changes with commit messages.

You often see commits with messages like

> fix test

or

> Added stats x and z to dashboard

or

> :sob:

The problem is when we 6 months later discovers a bug that was introduced in the commit `Added stats x and z to dashboard` which is 17 changed files with 231 lines added and 29 lines deleted. Then you stare at your screen and wonder what was going through your head when making all these changes. Why did you make this weird control structure.

If we would have just put a little a bit more time on describing the changes the code might have been a bit more easy to understand.

I and many others write commit messages like the ones above sometimes. It is often because of habit, laziness and that you haven't really thought about the great possibilities commit messages gives us. We just want to tick of another todo and push the new code to master.

# How can you write commit messages?

The first step is to divide the work into smaller commits to make it possible to describe each change with a title and a few sentences. If it feels hard to describe the current code change set it is a good sign that is is time to divide the change into smaller commits.

I have started to try to think of my commit messages as e-mail messages to myself that I will read in a year or so. Each commit message has a subject and a body. If there is a related issue in GitHub I include a reference to that in the commit message. I try to remember myself that giving the commit message an extra 30 seconds of thought can possible save me a couple of hours of work in a possible future.

## A commit message structure

A style that I think works well is this:

### First a subject

* Start with a title or subject, which should be about 70 characters long. Most places where you can view git commits expect that the subject line is around 50 characters. GitHub has a generous display limit at 70 characters for example.
* If the commit has something to do with an issue and I will add a reference to it the first on the subject
* The subject should be a super short summary of the changes done. Technical details are saved for the commit message body.
* The subject should not end with a period.
* The subject is the part of the commit that is most likely to be shown so it's good to spend time to make it easily understandable and clear.

### Then a blank line

* As a divider between the subject and body

### Third the body

* What is the reason for this code change.
* Why did you chose to do in a specific way.
* Is there anything that can be useful to think about when you look at the change, something that is not clear or easy to miss?
* Please use bullet points to make it clear.
* Feel free to add reference links. Like maybe you got inspiration to this way of solving a bug from something you found on StackOverflow.

# Use imperative, present tense

It is recommended in [the Git docs](http://git.kernel.org/cgit/git/git.git/tree/Documentation/SubmittingPatches?id=HEAD) that commit messages are written in the imperative, present tense. That means that you use use "fix" instead of "fixed" or "add" instead of "added" when writing your commit messages.

You can see an example of this in how git expresses itself when it creates automatic commit messages such as "Merge branch 'master' of github.com: example / app". Think about this like you are describing what happens as each commit is applied to the code.

Also, if you just decide to follow this you never have to think about tense when writing a commit messge.

# A closing thought

There is no way that is more right or wrong.

But, I have noticed that when I put more time into my commit messages I have to reflect more on the changes I make in a project. This increases the code quality and produce smaller and coherent commits as it adds a extra step where I am forced to reflect on new code.

I think the main thing is to realize what a fantastic tool git is and how we can use commit messages as a documentation and way to understand a project's history.

# Resources

Tim Pope: "A Note About Git Commit Messages"
http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

Guidelines for making patched to Git
http://git.kernel.org/cgit/git/git.git/tree/Documentation/SubmittingPatches
