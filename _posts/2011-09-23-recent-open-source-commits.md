---
title: Recent open source commits
---

Last week I did two small commits on a project called [mongo_session_store](https://github.com/brianhempel/mongo_session_store). 
It's a Rails session store that uses mongo_mapper, mongoid or the mongo ruby driver to store session data in a mongodb database.
It was started out by [compressed](https://github.com/compressed/mongo_session_store) about two years ago and has had a lot of forks,
many looks unmaintained. [Brian Hempel](https://github.com/brianhempel) has a fork that works good with Rails 3.x and that he is 
actively maintaining. Brian has also released it as gem called [mongo_session_store-rails3](https://rubygems.org/gems/mongo_session_store-rails3), 
that we're currently using for <a href="http://unicef.se">the swedish UNICEF site</a>.

<h3>My commits</h3>

[582154476b28f2b0e59c17e6649cfb8078dec13f](https://github.com/brianhempel/mongo_session_store/commit/582154476b28f2b0e59c17e6649cfb8078dec13f)
 - There was an error in a example in the readme on how you set the <code>config.session_store</code> setting. When setting sessions store your
can't assign the store with a <code>=</code>.

[66baa116fe3be42f89a234ac2436c02ff717b9b4](https://github.com/brianhempel/mongo_session_store/commit/66baa116fe3be42f89a234ac2436c02ff717b9b4)
 - I also replaced a few <code>rescue LoadError</code> with <code>autoload</code>. It makes the code a bit cleaner and don't make you require 
 files that you won't be using.
