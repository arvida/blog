---
title: CircleCI with Rails, PostgreSQL and custom collation
---


At [Oktavilla](http://oktavilla.se/) we are in the process of moving a [RubyOnRails](http://rubyonrails.org/) application from [MySQL](https://www.mysql.com/) to [PostgreSQL](http://www.postgresql.org/). For this appliction we use the excellent [CircleCI](https://circleci.com) to automatically run the test suit when new commits are pushed to GitHub. This application is in swedish so we want to setup the database with collation set to `sv_SE.UTF-8` to make sorting work correctly. 

This didn't work out of the box on CircleCI. After some testing and reading we ended up with this.


A custom `database.yml` for CircleCI. Create a file in config/database.ci.yml with:

{% highlight yaml %}
test:
  strict: false
  database: circle_ruby_test
  adapter: postgresql
  username: ubuntu
  host: localhost
  encoding: utf8
  collation: sv_SE.UTF-8
  template: template0
{% endhighlight %}

Note that `collation` and `template` is set. Read more on PostgreSQL database templates in [the docs](http://www.postgresql.org/docs/9.3/static/manage-ag-templatedbs.html).

Our `circle.yml` looks like this:

{% highlight yaml %}
machine:
  environment:
    SPEC_OPTS: '--format doc'
    PGDATA: /var/lib/postgresql/9.4/main
dependencies:
  pre:
    - sudo locale-gen sv_SE.UTF-8 
    - sudo -E -u postgres /usr/lib/postgresql/9.4/bin/pg_ctl restart; sleep 1 
database:
  override:
    - mv config/database.ci.yml config/database.yml
    - bundle exec rake db:create db:schema:load --trace
{% endhighlight %}

First we have to create the system locale using `locale-gen`. This requires a restart of PostgreSQL and some sleep time to let it finish the startup sequence. Then we override the default database setup and use our own `database.ci.yml` and create the database.
