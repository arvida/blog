title: Sensitive data in git repositories

~

The other day I got into a discussion about storing AWS credentials in a project's
git repository. The credentials were used for deploying a static site to S3 and
the argument was that _”it makes it much easier to get started if the credentials
already exists in the project when cloned, and as the repo is a private GitHub repository we
don't have to worry about any unauthorised access”_.

Years of being forced to handle Ruby On Rails's database.yml and similar files
has made into a habit for me to always keep a projects credentials and sensitive data in
separate files that are ignored by git. Approached with the above reasoning
made me realise that I might live in a bit of a bubble when it comes to this. Coming
from another background and you might very well have a another view on how to
handle credentials in projects.

I instinctively felt that the above approach was not ideal. Phrasing a sound
explanation to why this is a bad idea took some time; the rest if this post is
the arguments I came up with.

## Why is this important?

We owe it to our customers and our selves to do as much as is reasonably possible
to ensure the security of data and credentials. The key way to do this is by
minimizing the places where sensitive data exists. Every time you put the
sensitive data somewhere you increase the chances of unauthorized access.

Once you have put sensitive data in a git repo it is going to stay in the
repository's history forever ([there are ways around this](https://help.github.com/articles/remove-sensitive-data)). You never know where a project folder might end up
in the future. Stay safe and make it easy for yourself by handling things like this right from the start of a projects life.

[GitHub](https://github.com/) is a truly awesome service and I have much respect for it and the people
behind it. Still I feel that it is unwise to put any sensitive data in code
that is hosted on GitHub and similar services. The reason for this is that websites gets compromised, even [GitHub has been
compromised](https://github.com/blog/1068-public-key-security-vulnerability-and-mitigation) in the past. It is better to minimize the impact if this happens in the future.

Another reason to keep sensitive data out of private repositories on services is external applications that have access to your repositories via
for example [GitHub's OAuth2 authentication](http://developer.github.com/v3/oauth/#scopes). Some [of](http://airbrake.io) [the](http://tddium.com/) [apps](http://prose.io/) using GitHub's API request
permission to access your private repos. These are great services that have good intentions but
once they have access to your private repositories they also introduce another way to get access your sensitive data if it is available in your git repository. Remember, these services can also get hacked.

Finally. Code and configuration (like credentials and sensitive data) is separate parts of a
application and varies between different deployments like staging and
production. It comes down to good design to keep these separate. The [12 Factor
app method](http://www.12factor.net/) describes a great policy regarding this in [the Config chapter](http://www.12factor.net/config): _”the litmus test is whether an app could be open sourced at any time without compromising any credentials”_.

## Handle sensitive data in a project

The main idea is to keep files with sensitive data separate from files with
your application code. The files containing credentials should been added to
.gitignore to ensure that they are never accidentally committed. The
application code then includes these files as they are needed.

The first time someone clones the project the cloner will need to setup these file with the
required credentials. It is a good idea to provide templates for these files in the repository
and to include some information on setup and where to find the credentials in
the projects readme file. I also suggest using a service like [Passpack](http://passpack.com/) or [Swordfish](https://github.com/github/swordfish)
to handle sharing of credentials and other sensitive data.

Another approach is to store your credentials in environment variables and
use something like [dotenv](https://github.com/bkeepers/dotenv) to setup these when running
locally. On the production server you have these setup automatically for the
application when launched. Checkout out how [Heroku uses environment variables](https://devcenter.heroku.com/articles/config-vars) for application configuration for inspiration on this approach.

## More resources

Figaro is alternative to dotenv mentioned above<br>
[https://github.com/laserlemon/figaro](https://github.com/laserlemon/figaro)

Econfig is a ruby gem for configuring Rails applications<br>
[https://github.com/elabs/econfig](https://github.com/elabs/econfig)

<div id="#gh-remove-sensitive-data"></div>
GitHub's guide to removing accidentally commited sensitive data from a
repository
[https://help.github.com/articles/remove-sensitive-data](https://help.github.com/articles/remove-sensitive-data)

How GitHub was hacked last year<br>
[https://gist.github.com/peternixey/1978249](https://gist.github.com/peternixey/1978249)
