title: Best practices in modern web projects

~

At [Oktavilla](http://oktavilla.se) we regularly start new projects. Over the years this has made us to come up with a few best practices to ensure that it is easy to take part in our projects and reduce errors. We use these in all our projects, both internal and for clients. In the end we deliver high quality  web projects and this is one part of that process.  

In this blog post I focus on practices related to the technical side of things. Like setup and what think about when choosing tools and processes. Each practice has a link or two in the end to resources with more information. 

## The README file

A project must have a README file in it's root directory. It contains information on the project and how get started with it. A new team member should easily get a understanding of what this project is and how to get started working with it from reading this file. 

When writing the README think of the reader as a novice with basic knowledge of programming environments. Format your text with [Markdown](http://daringfireball.net/projects/markdown/) to make it easy for the reader to digest. Markdown is both easily read as source code and can be rendered as HTML (Github does this automatically for example).

A README should include at least the following sections:

### Introduction

A brief introduction that explains what the purpose of this project is. Also include the projects role if it is a part of larger project architecture, who the client might be and any other information that might be good to know.

### Dependencies

Include a list of on dependencies that needs to be installed separately. For example: database servers, package managers and programming languages. Be sure to include what versions that are required as well.

### Local development setup

Someone who is new to the project should easily understand how get it up and running for local development using the README. Let the reader know what steps to take with a freshly made copy of the projects code. This can be notes on how to install needed packages, start the application and run the tests. 

Use concrete example like what to type into the shell to invoke the different steps.

### Configuration

If the application can be configured using environment variables include a list of these. Explain what each environment variable is used for.

### Deploy

Part of working on a project is also being able to deploy your changes. Let the reader know how to deploy code to production and staging environments. 

For example if you use [Heroku](http://heroku.com); include concrete example on how to set up the different git remotes used for deploy and how to push code to these.

* [Readme Driven Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)
* [How To Write A Great README](http://robots.thoughtbot.com/how-to-write-a-great-readme)
* [The Most Important Code Isn't Code](http://zachholman.com/posts/documentation/)

## Git

First of all, use git for version control. It is modern, works great and the majority of developers are either comfortable using it or want to start using it. 

### Deployable master branch

Keep the master branch deployable at all times. Sooner or later you will get a bug reported on the code running in production that needs to be fixed right away. Always keeping your current work in a separate branch to allow fast switching to the master for the bug fix and the courage to deploy without the risk of putting any new or unknown code in front of your application users.

### Commit messages

Strive to write informative commit messages. A good commit message should include a short title and body. The title explains what the purpose of the change is and the body gives more information on why this change was needed. Think of commit messages as documentation for your code.

If there is any extra information that might be useful for someone looking at the commit include that in the body. For example, if there is a corresponding issue in your issue tracker be sure to include a reference to the related issue.

### Pull requests

Use a web based git hosting alternative like [GitHub](https://github.com/) or [BitBucket](https://bitbucket.org/) that support pull requests for branches. This let you tell other team members about code changes before they are merged into the master branch.

Use this for discussion and to spread knowledge about different parts the code base by [code reviews](http://en.wikipedia.org/wiki/Code_review). Code reviews can be both high level or very thorough. The important thing is that someone more than the author takes a look at the changes and says “thumbs up” before the code is merge into the master. 

Be open to discussion, but don't let the review process hold back a merge to long. It is all team members responsibility to be keep the process quick and smooth within reasonable limits.

It is also a good idea to keep an extra friendly tone in the discussions to avoid misunderstands and grief. Use [emojis](http://www.emoji-cheat-sheet.com/) to keep the discussion fun and productive.

* [Understanding the GitHub Flow](https://guides.github.com/introduction/flow/index.html)
* [How GitHub Uses GitHub to Build GitHub](https://www.youtube.com/watch?v=qyz3jkOBbQY)
* [A Note About Git Commit Messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
* [Agile Development with Heroku Webinar](https://www.youtube.com/watch?v=Y1oNCb-S_aM)

## Configuration

Most applications have some kind of configuration. It can be a connection URL for a database, API credentials for external services or something else.

Unix like operation systems have great method for providing applications with configuration values at run time. It is called [environment variables](http://en.wikipedia.org/wiki/Environment_variable). Use this and store all application configuration as environment variables. 

Using environment variables allows for a separation of configuration from the code base. This makes it easy to change configuration values for a deployed application without updating any code. 

A good goal is that the application can be open sourced at any time without compromising any credentials.

* [The twelve-factor app](http://12factor.net/config)
* [Heroku dev center: Configuration and Config Vars](https://devcenter.heroku.com/articles/config-vars)

## Package managers

All projects have some kind of external dependencies on libraries and most programming languages have at least one package manager to handle installation of these. For example ruby has [bundler](http://bundler.io/) and node.js has [npm](https://www.npmjs.org/). Use a package manger and be sure to include the file that specifies package versions in the project.

Once in a while go trough the dependencies list and check what packages have been updated and if the updates might be of interest. For example, you can do this easily with bundler using the command `bundle outdated` or with npm using `npm outdated`. 

A majority of “good” packages use [semantic versioning](http://semver.org/). With this you can tell from the version number if a version is backwards compatible, add new features or just fixes bugs. Using this you can know what to expect from new versions of a package.

* [Package.json dependencies done right](http://blog.nodejitsu.com/package-dependencies-done-right)

## Deploy

The deploy procedure should be automated so it requires a minimum of human interaction. With the information from the README and correct credentials it should be a matter of running a command in the shell or pressing a button to put a new version of the application online. 

Automation is important to avoid human errors. If there are any manual tasks involved with making a deploy, sooner or later someone will forget to do these or not get them done correctly. There can be bugs in deploy scripts but once they are discovered and fixed they will not happen again.

* [Why Continuous Deployment?](http://www.startuplessonslearned.com/2009/06/why-continuous-deployment.html)
* [Continuous delivery](http://en.wikipedia.org/wiki/Continuous_delivery)

## Application environments

A application should be capable of behaving differently depending of what environment it is run in. 

Examples of different behaviours that depends on the current environment might be how much detail is displayed on error pages, what goes in to log files, javascript minification or if the application should send e-mail messages. Using environments you get a common way to handle these special cases.

The default environments are `development`, `test`, `staging` and `production`. Development is the default mode that the application run in when you run it locally. Test is the environment your tests run in. Staging and production are environments that the application run in when deployed.

The application picks up what environment to run in from a environment variable. These are usually called something like `NODE_ENV` or `RAILS_ENV`.

* [Beyond the default Rails environments](http://signalvnoise.com/posts/3535-beyond-the-default-rails-environments)
* [The Twelve-Factor App - Dev/prod parity](http://12factor.net/dev-prod-parity)

## Static files through a CDN

Static files like images, fonts, CSS and javascript for a production applications should not be served from the same server as the application to end users. Serve these through a CDN that is optimised for serving static files to ensure high transfer speeds and therefore increased user happiness.

A common way to solve this is using a CDN with a custom origin set up and cache busting by file name. With this the application will add the CDN-host and a hash of the files contents to all files that should be served through the CDN when run in the production environment. 

For example a stylesheet link tag will look like this in the development environment:
 
<% highlight :html do %>
<link href="/style.css" rel="stylesheet" type="text/css">
<% end %>

.. and like this in production: 

<% highlight :html do %>
<link href="http://my-cdn.com/style-a06ae46033959f7563b20c5faff6f5e60175253f.css" rel="stylesheet" type="text/css">
<% end %>

When the CDN gets a request for a file it is missing it will request and cache that file from the application's production server. As the hash is unique to the file contents the CDN will always fetch the correct version as long as the app outputs correct links in the markup. This also requires the app to handle fetching of static files with a hash appended to the filename. This can be solved by either a simple route rewrite or a precompilation task run at deploy.

And, remember that Amazon S3 is not CDN. It is a service for storing files and it is not optimised delivery. Therefore don't use it as a CDN. This is a too common misunderstanding. [CloudFront](http://aws.amazon.com/cloudfront/) is the Amazon CDN offering. 

* [The Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
* [connect-assets](https://github.com/adunkman/connect-assets)

## Closing thoughts

All projects are different and of course the practices mentioned in this post are not valid for all projects. However, keeping a set of common practices for how to create, maintain and contribute to projects within a organisation makes things work smoother. It reduces setup time and makes it easy for new project members to get started contributing. Just make sure that the documentation for your practices are alive and evolves over time.



<p class="notice"><strong>Care about things like this?</strong> We are currently looking for application developers with a keen eye for details to join our team at <a href="http://oktavilla.se">Oktavilla</a>. <a href="mailto:arvid.andersson@oktavilla.se">Get in touch if you want to know more.</a></p>