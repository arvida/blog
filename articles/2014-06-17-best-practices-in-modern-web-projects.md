title: Best practices in modern web projects

~

Building stuff for the web is quite complex. Using common best practices make it a bit easier. At [Oktavilla](http://oktavilla.se) we regularly start new projects and over the years we have learned a lot the hard way. Applying these best practices and keeping them relevant and up-to-date has helped us make things run a lot smoother.

This is a summary of the best practises we use for modern web development projects. Each part has a link or two in the end to resources with more information. These are the parts I’ll cover:

* [The README file](#the-readme-file)
* [Version Control and Git](#version-control-and-git)
* [Configuration](#configuration-1)
* [Package Managers](#package-managers)
* [Deploy](#deploy-1)
* [Application Environments](#application-environments)
* [Static files through a CDN](#static-files-through-a-cdn)

## The README file

Let’s start out with the most important file in any project.

A project must have a README file in its root directory. It contains information on all the why’s and how’s for the project. Any team member, new or old, should easily get a understanding of what the project is and how to work with it from reading this file.

When writing the README think of the reader as a novice with basic knowledge of programming environments. Format the text with [Markdown](http://daringfireball.net/projects/markdown/) to make it easy for the reader to digest. Markdown is both easily read as source code and can be rendered as HTML (GitHub does this automatically for example).

A README should include at least the following sections:

### Introduction

A brief explanation of the projects purpose. If it is part of a larger architecture be very clear about the projects role in said architecture.

### Dependencies

Include a list of dependencies that need to be installed separately. For example: database servers, package managers and programming languages. Be sure to include what versions are required as well.

### Local Development Setup

Someone who is new to the project should easily understand how get to it up and running for local development using the README. Let the reader know what steps to take with a fresh copy of the project’s code. This can be notes on how to install needed packages, start the application and run the tests.

Use concrete examples like what to type into the shell to invoke the different tasks.

### Configuration

If the application can be configured using environment variables include a list of these. Explain what each environment variable is used for.

### Deploy

Part of working on a project is also being able to deploy your changes. Let the reader know how to deploy code to production and staging environments.

For example, if you use [Heroku](http://heroku.com), include examples on how to set up the different Git remotes used for deployment and how to push code to these.

* [Readme Driven Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)
* [How To Write A Great README](http://robots.thoughtbot.com/how-to-write-a-great-readme)
* [The Most Important Code Isn’t Code](http://zachholman.com/posts/documentation/)

## Version Control and Git

First of all, use version control. Second, use Git for version control. It is modern, works great and a majority of developers are either comfortable using it or want to start using it.

### Deployable at All Times

Keep the master branch deployable at all times. Sooner or later you will get a bug reported on the code running in production that needs to be fixed right away. Keeping your current work in a separate branch allow you to quickly switch to the master branch and fix the bug. It also gives you the peace of mind to deploy without worrying about accidentally pushing any new and untested code to your users.

### Commit Messages

Write informative commit messages. A good commit message includes a short title and a body. The title explains the purpose of the change and the body gives more information on why this change was needed. Think of commit messages as the documentation of the  changes made to the code.

If there is any extra information that might be useful for someone looking at the commit, include that in the body. For example, if there is a corresponding issue in your issue tracker be sure to include a reference to it.

### Pull Requests

Use a web based Git hosting alternative like [GitHub](https://github.com/) or [BitBucket](https://bitbucket.org/) that supports pull requests for branches. This lets you tell other team members about code changes before they are merged into another branch.

Use the pull request to discuss and spread knowledge about the different parts of the code base and changes to it by [code reviews](http://en.wikipedia.org/wiki/Code_review). Code reviews can be both high level or very thorough. The important thing is that someone else other than the author takes a look at the changes and says “thumbs up” before the code is merged.

Be open to discussion, but don’t let the review process hold back a merge too long. It is every team member’s responsibility to keep the process quick and smooth.

It is also a good idea to keep an extra friendly tone to avoid misunderstandings and grief. Use [emojis](http://www.emoji-cheat-sheet.com/) extensively to keep the discussion fun and productive.

* [Understanding the GitHub Flow](https://guides.github.com/introduction/flow/index.html)
* [How GitHub Uses GitHub to Build GitHub](https://www.youtube.com/watch?v=qyz3jkOBbQY)
* [A Note About Git Commit Messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
* [Agile Development with Heroku Webinar](https://www.youtube.com/watch?v=Y1oNCb-S_aM)

## Configuration

Most applications have some kind of configuration. It can be a connection URL for a database, API credentials for external services or something else.

Unix-like operation systems have a great method for providing applications with configuration values at run time. It is called [environment variables](http://en.wikipedia.org/wiki/Environment_variable). Use them to store all the applications configurations.

Using environment variables allows for a separation of configuration from the code base. This makes it easy to change configuration values for a deployed application without updating any code.

A good goal is that the application can be open sourced at any time without compromising any credentials.

* [The twelve-factor app](http://12factor.net/config)
* [Heroku dev center: Configuration and Config Vars](https://devcenter.heroku.com/articles/config-vars)

## Package Managers

All projects have some kind of external dependencies on libraries and most programming languages have at least one package manager to handle installation of these. For example ruby has [bundler](http://bundler.io/) and node.js has [npm](https://www.npmjs.org/). Use a package manager and be sure to include the file that specifies package versions in the project.

Go through the list of dependencies once in a while and check which packages have been updated and if the update might be of interest. For example, you can do this easily with bundler using the command `bundle outdated` or with npm using `npm outdated`.

A majority of “good” packages use [semantic versioning](http://semver.org/) which helps you understand what to expect from a new version of a package. It tells you if a version is backwards compatible, adds new features or just fixes bugs.

* [Package.json dependencies done right](http://blog.nodejitsu.com/package-dependencies-done-right)
* [Semantic Versioning](http://semver.org/)

## Deploy

The deploy procedure should be automated so it requires minimum human interaction. With the information from the README and correct credentials it should be a matter of running a command in the shell or pressing a button to put a new version of the application online.

Automation is important to avoid human errors. If there are any manual tasks involved with making a deploy, sooner or later someone will forget to do them or do them incorrectly. There can be bugs in deploy scripts but once they are discovered and fixed they will not happen again.

* [Why Continuous Deployment?](http://www.startuplessonslearned.com/2009/06/why-continuous-deployment.html)
* [Continuous delivery](http://en.wikipedia.org/wiki/Continuous_delivery)

## Application Environments

An application should be capable of behaving differently depending on what environment is running it.

Examples of different behaviours that depend on the current environment might be how much detail is displayed on error pages, what goes into log files, javascript minification or if the application should send e-mails. Using environments you get a common way to handle these cases.

The default environments are `development`, `test`, `staging` and `production`. Development is the default mode that the application runs in when you run it locally. Test is the environment your tests run in. Staging and production are environments that the application runs in when deployed. The production environment is where the actual end users use the application and staging is a replica of production that is used to test changes before they are pushed to production.

The application picks up what environment to run in from an environment variable. These are usually called something like `NODE_ENV` or `RAILS_ENV`.

* [Beyond the default Rails environments](http://signalvnoise.com/posts/3535-beyond-the-default-rails-environments)
* [The Twelve-Factor App - Dev/prod parity](http://12factor.net/dev-prod-parity)

## Static Files Through a CDN

Static files like images, fonts, CSS and Javascripts should be served through a content delivery network, CDN. They are built and optimised for serving static files to users all over the globe fast. A faster experience makes for happier users.

Getting your files on the CDN should be part of your automated deployment procedure. A common way to solve this is by using a CDN with a custom origin set up and cache busting by file name. With this the application will add the CDN-host and a hash of the files contents to all files that should be served through the CDN when run in the production environment.

For example, a stylesheet link tag will look like this in the development environment:

    <% highlight :html do %>
    <link href="/style.css" rel="stylesheet" type="text/css">
    <% end %>

And like this in production:

    <% highlight :html do %>
    <link href="http://my-cdn.com/style-a06ae46033959f7563b20c5faff6f5e60175253f.css" rel="stylesheet" type="text/css">
    <% end %>

When the CDN gets a request for a file it is missing it will request and cache that file from the application. As the hash is unique to the file contents the CDN will always fetch the correct version as long as the app outputs correct links in the markup. This also requires the app to handle fetching of static files with a hash appended to the filename. This can be solved by either a simple route rewrite or a precompilation task run at deploy.

And, remember that Amazon S3 is not a CDN and should not be used as such. This is a common mistake. It is a service for storing files and is not optimised for delivery. [CloudFront](http://aws.amazon.com/cloudfront/) is the Amazon CDN offering.

* [The Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
* [connect-assets](https://github.com/adunkman/connect-assets)

<p class="notice"><strong>Care about things like this?</strong> We are currently looking for Javascript and Ruby developers with a keen eye for details to join our team at <a href="http://oktavilla.se">Oktavilla</a>. <a href="mailto:arvid.andersson@oktavilla.se">Get in touch if you want to know more.</a></p>

_Many thanks to my colleague [Gustaf Forsslund](https://twitter.com/snurra) for a thorough proofreading of this blog post._
