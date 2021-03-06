---
title: Minimalicious testing in Ruby 1.9 with MiniTest
---

In this blog post I am going to try to do a introduction on writing tests in the style of [Behavior Driven Development (BDD) specifications](http://en.wikipedia.org/wiki/Behavior_Driven_Development), also called specs, with ruby's [__MiniTest__](https://github.com/seattlerb/minitest) framework. BDD is a big subject and I am going to focus on the tools MiniTest provides for specifying the behaviour of code. There are a lot more to BDD than what is mentioned in this blog post.

_I got the idea for the blog post while I was reading the excellent [The RSpec book](http://pragprog.com/book/achbd/the-rspec-book). Even though it is about a different testing framework called [RSpec](http://rspec.info/) I highly recommend reading it if you are interested in [automated testing](http://en.wikipedia.org/wiki/Test_automation) as it gives a great introduction on writing tests and what to think about when doing so. This blog post is kind of a  summary of my notes and thoughts that come up when looking into MiniTest::Spec while reading the the RSpec book and also a few bits I have picked up on my own journey towards learning to test my code better._

## MiniTest?

Since ruby 1.9 the ruby standard library has included a testing framework called [MiniTest](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest.html), it is a modern and lightweight replacement for ruby 1.8's [Test::Unit](http://ruby-doc.org/stdlib-1.8.7/libdoc/test/unit/rdoc/Test/Unit.html) framework. MiniTest provides:

* Unit tests with [MiniTest::Unit](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest/Unit.html)
* Specs with [MiniTest::Spec](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/spec/rdoc/MiniTest/Spec.html)
* mock objects with [MiniTest::Mock](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/mock/rdoc/MiniTest/Mock.html)
* algorithm performance tests

If you got ruby 1.9 MiniTest is installed and ready to go. 

Apart from beeing a sweet testing framwork that is included in ruby by default one of the great things with MiniTest is that the codebase is small and easy to read through. If you want to have a look at the code it is available at GitHub on [github.com/seattlerb/minitest](https://github.com/seattlerb/minitest). Another great thing is that it performs very well when it comes to speed.

MiniTest is maintained and developed by [Ryan Davis](http://www.zenspider.com/) of [Seattle Ruby Brigade](http://www.seattlerb.org/).

<span id="installing"></span>_If you need to install ruby 1.9 checkout [Ruby Version Manager](http://beginrescueend.com/) or [rbenv](https://github.com/sstephenson/rbenv) for easy installation and mangement of ruby versions._

### A note on MiniTest versions

One thing to be aware of is that the version of MiniTest included with your ruby is probably not the most recent version, on ruby 1.9.3-p125 version 2.5.1 looks to be included by default. The latest version of MiniTest is 2.11.3 (as of March 1 2012). If you experience something that looks like a bug or a missing feature that [the documentation](http://docs.seattlerb.org/minitest/index.html) says should be there a old version might be the reason.

If you want to install the latest version (or are on ruby 1.8) just do `gem install minitest` in your shell like usual when installing [ruby gems](http://rubygems.org/). You will also have to add to following to your tests in order to activate the gem version:

{% highlight ruby %}
require "rubygems"
gem "minitest"
{% endhighlight %}

If you are using [bundler](http://gembundler.com/) you just have to add `gem "minitest"` to your `Gemfile` and do the `bundle` command.

You can check your current version of MiniTest with irb:

{% highlight text %}
~ $ irb
ruby-1.9.3-p125 :001 > require 'minitest/unit'
=> true
ruby-1.9.3-p125 :002 > MiniTest::Unit::VERSION
=> "2.11.2"
{% endhighlight %}

There is a [History.txt](https://github.com/seattlerb/minitest/blob/master/History.txt) in the github repository for MiniTest that can be worth checking for info on the different versions if you run in to problems.

## Describing your code with specs

Writing specs is about specifying the behavior of your code by creating examples on how the code behaves. MiniTest provides a [domain specific language](http://en.wikipedia.org/wiki/Domain-specific_language) for doing this with [MiniTest::Spec](http://docs.seattlerb.org/minitest/MiniTest/Spec.html).

You basically use two methods called `describe` and `it` along with expectations that specifies what is needed to be fulfilled in order for the example to pass.

* `describe` defines what you are specifying. It takes a string (or something that can act as string) as a first argument. Also it lets you specify a optional “additional description” as a second argument.
* `it` defines a example (or “test case”). It takes a description along with a block as arguments, the block contains the code that is the “actual example“.
* expectations are implemented as methods you can call on any object, for example `person.name.must_equal 'Yukihiro'`, `result.wont_be_empty` and `duvel.abv.must_be_close_to 8.5`.

A spec for a very simple `Person` class would look like something like this:

{% highlight ruby %}
require "minitest/autorun"

describe "Person", "A simple person example" do

  it "has a full name" do
    person = Person.new("Yukihiro", "Matsumoto")
    person.full_name.must_equal "Yukihiro Matsumoto"
  end

end
{% endhighlight %}

The code above should be pretty self explanatory; we give an example on how a person has a full name that is based on it's first and last name. One thing that can be easy to miss in the beginning is the `require "minitest/autorun"` line, this is needed to include the MiniTest code and to trigger the actual execution of the test when the file run.

### Running the Person spec

First make sure that you are using ruby 1.9 by checking the output of `ruby -v`:

{% highlight text %}
$ ruby -v
ruby 1.9.3p125 (2012-02-16 revision 34643) [x86_64-darwin11.3.0]
{% endhighlight %}

If not checkout [the ruby version managers mentioned above](#installing).

Now, create a folder with two sub folders called “lib” and  “spec”. Create a file called “person_spec.rb” with the code listed above for the Person spec and save it to the spec folder then open up your terminal and run it:

{% highlight text %}
$ cd my-test-folder
$ ruby spec/person_spec.rb
{% endhighlight %}

You should see something like this as the output:

{% highlight text %}
Run options: --seed 57181

# Running tests:

E

Finished tests in 0.000852s, 1173.7089 tests/s, 0.0000 assertions/s.

  1) Error:
test_0001_has_a_full_name(Person::A simple person example):
NameError: uninitialized constant Person
	spec/person_spec.rb:7:in `block (2 levels) in <main>'

1 tests, 0 assertions, 0 failures, 1 errors, 0 skips
{% endhighlight %}

Now add a file called person.rb in the “lib” folder and require that file in person_spec.rb:

{% highlight ruby %}
require 'minitest/autorun'
require_relative "../lib/person"

describe "Person", "A simple person example" do
...
{% endhighlight %}

Run spec again and start writing code to fix the errors. You should end up with a `Person` class that might look something like this:

{% highlight ruby %}
class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
{% endhighlight %}

This is how the output of running the spec should look like after we have added a Person class with the `full_name` method:

{% highlight text %}
$ ruby spec/person_spec.rb
Run options: --seed 65168

# Running tests:

.

Finished tests in 0.000668s, 1497.0060 tests/s, 1497.0060 assertions/s.

1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
{% endhighlight %}

There is [a section further down in this post](#running) with more info on running specs.

### Nesting describe

Worth noting is that the `describe` method can also be nested to better outline different cases and states. Here we add a `valid?` method to the Person class:

{% highlight ruby %}
require "minitest/autorun"
require_relative "../lib/person"

describe Person do

  describe "when name is empty" do
    it "is not valid" do
      person = Person.new
      person.wont_be :valid?
    end
  end

  describe "when name is not empty" do
    it "is valid" do
      person = Person.new("Yukihiro", "Matsumoto")
      person.must_be :valid?
    end

    it "has a full name" do
      person = Person.new("Yukihiro", "Matsumoto")
      person.full_name.must_equal "Yukihiro Matsumoto"
    end
  end

end
{% endhighlight %}


### Setting expectations

MiniTest::Spec provides a bunch of different expectations you can use to create examples. If you have used RSpec one of the big differences you will notice is that MiniTest::Spec uses “must” instead of “should” and “wont” instead of “should_not”.

There is a common practice of limiting the number of expectations to as few
as possible per example, preferably one. The idea is that the examples gets easier to write and maintain by limiting the scope for each one.

#### Available expectations

The full list of available expectations is available in [the documentation](http://docs.seattlerb.org/minitest/MiniTest/Expectations.html) for MiniTest. A few of the highlights:

* `book.title.must_equal 'Lord of the rings'`
* `book.title.must_be_nil`
* `book.title.must_match /Jello/`
* `params[:post_ids].must_include 23`
* `params[:post_ids].must_be_empty`
* `result.must_be_instance_of ChocolateFactory`
* `proc { subject.rm_f }.must_output "* Warning: Deleting all files!"` for expecting output to stdout/stderr
* `result.must_be_close_to 2.55, 0.005` the result must be within 2.545 and 2.555,  for comparing floats
* `player.wow_level.must_be :>, 32`
* `kitten.must_be :cute?` this only works in MiniTest from version 2.6.0

You can make negative expectations by changing `must_` to `wont_` in most cases.

## Hooks

MiniTest offers two hooks called `before` and `after` that you can use to specify a block of code that will be executed before and/or after each example. The hooks can be specified multiple times, however you should only use them once on each level of describe to ensure clarity. These are useful to avoid repetition between the examples.

{% highlight ruby %}
describe Person do

  before do
    @person = Person.new
  end

  describe "name is empty" do
    it "is not valid" do
      @person.valid?.wont_equal true
    end
  end

  describe "name is not empty" do
    before do
      @person.first_name = "Yukihiro"
      @person.last_name = "Matsumoto"
    end

    it "is valid" do
      @person.valid?.must_equal true
    end

    it "has a full name" do
      @person.full_name.must_equal "Yukihiro Matsumoto"
    end
  end

end
{% endhighlight %}

There is also a special hook called `after_tests` that allows you to execute a block of code after the whole test suit has been run. This hook can also be invoke multiple times to add more code to be run after the tests are done, however in most cases I would recommend to only invoke this once and in a [spec_helper](#multipletestfiles) or similar file to avoid confusion.

{% highlight ruby %}
MiniTest::Unit.after_tests do
  destroy_sandbox
  puts $debug_info
end
{% endhighlight %}

## Helpers

MiniTest provides a couple of helper methods to make your specs easier to read more convinient to write.

### let

`let` is like simplified version of the before hook that you use to setup predefined accessors and the values they return:

{% highlight ruby %}
describe Person do

  let(:person) { Person.new("Yukihiro", "Matsumoto") }

  it "has a full name" do
    person.full_name.must_equal "Yukihiro Matsumoto"
  end

end
{% endhighlight %}

### subject

`subject` works similar to let but you can only use it to set a accessor called subject. This is used to specify the object who's behavior is being described:

{% highlight ruby %}
describe Person do

  subject { Person.new("Yukihiro", "Matsumoto") }

  it "has a full name" do
    subject.full_name.must_equal "Yukihiro Matsumoto"
  end

end
{% endhighlight %}

### specify

`specify` is a alias for `it`, it is usually used where it doesn't make sense to describe the example with a string:

{% highlight ruby %}
describe Person do

  subject { Person.new }

  specify { subject.posts.must_be_empty }

end
{% endhighlight %}

### skip

`skip` provides a way to skip examples from being run, the method takes a string as optional argument that can be used to provide a explanation to why that example is skipped:

{% highlight ruby %}
describe Ticket do

  it "expires after one year" do
    skip "Vending machine clock is broken"
    t = Ticket.new(:created_at => 1.year_ago)
    t.expired?.must_be true
  end

end
{% endhighlight %}

The code after `skip` is not run in the example and is reported as “Skipped” (a S instead of a .) in the output when running the tests:

{% highlight text %}
$ ruby spec/ticket_spec.rb
Run options: --seed 48730

# Running tests:

S

Finished tests in 0.000633s, 1579.7788 tests/s, 0.0000 assertions/s.

1 tests, 0 assertions, 0 failures, 0 errors, 1 skips
{% endhighlight %}

This can be handy if you want to hide error messages while doing [refactorings](http://en.wikipedia.org/wiki/Refactoring) or to describe a bug that you are not going to fix this very minute.

Another way of doing skips is using the `it` method without a block. This can be used to keep a list of tests that you plan to write. As skipped tests gets marked in the output you will get reminded that there are examples left to write.

{% highlight ruby %}
describe Ticket do

  it "expires after one year"
  it "has a description"
  it "belongs to a venue"

end
{% endhighlight %}

## Test doubles

Test doubles are pretend objects that acts as an another object. They are useful when you are writing examples for code that collaborates with other objects as you can focus on writing one example at a time without depending on the implementation and inner workings of the other objects. Test doubles can also make your specs fast and more predicable as you can pretend to make requests to external services or databases and the result. However overuse of test doubles can cause a lot of problems and if your test doubles starts to get complicated it is probably a deeper problem and sign of a [code smell](http://en.wikipedia.org/wiki/Code_smell). 

The two most common test double types I have come accross when writing tests are `stubs` and `mocks`. _A stub object_ is a pretend object that implement some of the interface of the object it pretends to be and returns predefined responses. _A mock object_ is similair to a stub but has another use case: it helps decide if the test case it is used in passes by verifying if it's methods has been called or not.

_Read more about different types of test doubles over at [wikipedia](http://en.wikipedia.org/wiki/Test_double)._

### Mocking

MiniTest provides a [Mock](http://docs.seattlerb.org/minitest/MiniTest/Mock.html) class that is used to create mock objects. You setup expectations for what methods are going to be called on the mock object with a method called `expect` that takes the method name and return value as arguments. You can also [set what arguments must be passed](http://docs.seattlerb.org/minitest/MiniTest/Mock.html) when calling the method. 

To verify if the expectations have been met you call `verify` on the mock object, if not all expected methods have been called the example will fail. An example where we want to verify that the `name` method on the author object is used when generating a book description:

{% highlight ruby %}
describe Book do

  it "uses authors name in description" do
    author = MiniTest::Mock.new
    author.expect(:name, "Robin Hobb")
    book = Book.new("Royal Assassin", :author => author)

    book.description.must_match /Written by Robin Hobb/
    author.verify
  end

end
{% endhighlight %}

### Stubbing

When it comes to stubs MiniTest doesn't provide a solution on how to do this. However there are a couple options on how to do stubbing with what is included in ruby by default.

The simplest way is to just use pure ruby code:

{% highlight ruby %}
describe Book do

  it "includes authors name in description" do
    robin = Class.new do
      def self.name
        "Robin Hobb"
      end
    end
    # can also be written like:
    # 	robin = Class.new
    # 	def robin.name; "Robin Hobb" end

    book = Book.new("Royal Assassin", :author => robin)

    book.description.must_match /It is written by Robin Hobb/
  end

end
{% endhighlight %}


Another approach is using ruby's [`Struct`](http://ruby-doc.org/core-1.9.3/Struct.html) class:

{% highlight ruby %}
describe Book do

  it "includes authors name in description" do
    author_stub = Struct.new(:name)
    robin = author_stub.new("Robin Hobb")
    # can also be written like:
    # 	robin = Struct.new(:name).new("Robin Hobb")

    book = Book.new("Royal Assassin", :author => robin)

    book.description.must_match /It is written by Robin Hobb/
  end

end
{% endhighlight %}

Ruby also provides a alternative _struct like_ class called [`OpenStruct`](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html) which might feel a bit more natural to use than `Struct`:

{% highlight ruby %}
require "ostruct"

describe Book do

  it "includes authors name in description" do
    robin = OpenStruct.new(:name => "Robin Hobb")
    book = Book.new("Royal Assassin", :author => robin)

    book.description.must_match /It is written by Robin Hobb/
  end

end
{% endhighlight %}

#### Partial stubbing

Partial stubbing is when you want use a “real object” in your tests but want to stub  some of the methods of that object, for example to avoid hitting the network or to freeze the time. These kinds of stubs are easily added in ruby thanks to it's dynamic workings. Let's say we want to check that the published at timestamp is glorified correctly for a book:

{% highlight ruby %}
describe Book do

  it "glorifies published at" do
    book = Book.new
    def book.published_at
      Time.new(2012, 1, 2)
    end

    book.glorified_published_at.must_equal "The most awesome and first Monday of the glorious year of 2012"
  end

end
{% endhighlight %}

### Test double libraries

There are a couple of gems that provide different and more refined ways to create test doubles that works with MiniTest, for example: [Mocha](http://mocha.rubyforge.org/), [RR](https://github.com/btakita/rr) and [FlexMock](http://flexmock.rubyforge.org/).

If you are making HTTP calls in your code also checkout [WebMock](https://github.com/bblimke/webmock) and [VCR](https://github.com/myronmarston/vcr) for some great ways to mock and stub HTTP services.

## Running your tests

<span id="running"></span>To run a single spec you just feed it to the ruby interpreter:

{% highlight text %}
$ ruby spec/beer_spec.rb
{% endhighlight %}

Depending of how you require files in your tests you might need to supply ruby with additional paths for $LOAD_PATH with the `-I` option:

{% highlight text %}
$ ruby -Ilib -Ispec spec/beer_spec.rb
{% endhighlight %}

MiniTest provides a verbose output format with the `--verbose` (or `-v`) option. This will print each example with it's name and how long it took to run:

{% highlight text %}
$ ruby spec/beer_spec.rb --verbose
Run options: --verbose --seed 18215

# Running tests:

Beer#test_0001_has_a_name = 0.00 s = .
Beer#test_0002_has_a_description = 0.00 s = .
Beer#test_0003_can_be_opened = 0.00 s = .


Finished tests in 0.001147s, 2615.5187 tests/s, 2615.5187 assertions/s.

3 tests, 3 assertions, 0 failures, 0 errors, 0 skips
{% endhighlight %}

There are also a option for specifying what tests to run based on the name. You do this with the `--name` (or `-n`) option that you supply with a regex.
Here we only run want to run the example matching “description“:

{% highlight text %}
$ ruby spec/beer_spec.rb --name /description/
Run options: --name /description/ --seed 64925

# Running tests:

.

Finished tests in 0.000962s, 1039.5010 tests/s, 1039.5010 assertions/s.

1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
{% endhighlight %}

### Multiple test files

<span id="multipletestfiles"></span>If you have more than one test file [rake](http://rake.rubyforge.org/) provides a great way to run multiple tests with it's `TestTask` class. You add a test task by creating a file called “Rakefile” in your projects root with the following contents:

{% highlight ruby %}
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end
{% endhighlight %}

With this rake task you can do `rake test` in the shell and all the files in the “spec“ folder ending with “_spec.rb” will be run. The `pattern` option tells rake what files to be considered as tests, here the double asterisks makes the rake task look recursivly for test files to run.

There are a few more options you can use to customize test tasks, for example you can provide the task with a option called `libs` to add directories to ruby's `$LOAD_PATH` before running the tests. Read more about this [in the Rake documentation](http://rake.rubyforge.org/classes/Rake/TestTask.html).

In order to pass MiniTest options to the rake task you have to put those in a environment variable called TESTOPTS:

{% highlight text %}
$ rake test TESTOPTS="--verbose"
Run options: --verbose --seed 18215

# Running tests:

Beer#test_0001_has_a_name = 0.00 s = .
Beer#test_0002_has_a_description = 0.00 s = .
Beer#test_0003_can_be_opened = 0.00 s = .


Finished tests in 0.001147s, 2615.5187 tests/s, 2615.5187 assertions/s.

3 tests, 3 assertions, 0 failures, 0 errors, 0 skips
{% endhighlight %}

The `--verbose` and `--name` options gets especially useful when you have a large test suit and want to see which examples are slow or just want to run a single example when fixing a bug.

If you got code or setup that you share between the specs it is common practice to have a `spec_helper.rb` file in the spec folder that contains the shared code that you require in the specs where this code needed.

When you have a big suit of tests that takes some time to you can hit `CTRL-T` while the test are running get a progress report.

## Resources

### Prettifying the output

To make the output of running your MiniTest specs a bit more pretty and informative there are a few options; for example checkout [TURN](https://github.com/TwP/turn), [purdytest](https://github.com/tenderlove/purdytest) and [minitest-reporters](https://github.com/CapnKernul/minitest-reporters). MiniTests also provides it's own solution for this called [pride](https://github.com/seattlerb/minitest/blob/master/lib/minitest/pride.rb), just add `require "minitest/pride"` to your spec for some fabulousness.

### Rails

As you might have guessed MiniTest::Spec should work great for testing Rails apps. There is a gem called [minitest-rails](https://github.com/blowmage/minitest-rails) that lets you use MiniTest::Spec for testing Rails 3 projects. Also checkout a blog post named [A better way of testing Rails application with minitest](http://blog.rawonrails.com/2012/01/better-way-of-testing-rails-application.html) by Rafał Wrzochol and one called [Using MiniTest::Spec With Rails](http://metaskills.net/2011/03/26/using-minitest-spec-with-rails/) by Ken Collins for more info on getting started with this.

There are also [a RailsCast Pro episode](http://railscasts.com/episodes/327-minitest-with-rails) and Avdi Grimm's excellent book [Objects on Rails](http://objectsonrails.com/) that includes a lot of examples on using MiniTest::Spec in a Rails app.

### More

Two very recomended talks covering MiniTest are Ryan Davis [Size Doesn't Matter](http://confreaks.com/videos/618) at Cascadia Ruby 2011 and [Aaron Patterson](http://tenderlovemaking.com/)'s [Hidden Gems of Ruby 1.9](http://www.confreaks.com/videos/367-gogaruco2010-hidden-gems-of-ruby-1-9) from Golden Gate Ruby Conference 2010.

There are a good introduction article on MiniTest::Spec called [A MiniTest::Spec Tutorial: Elegant Spec-Style Testing That Comes With Ruby](http://www.rubyinside.com/a-minitestspec-tutorial-elegant-spec-style-testing-that-comes-with-ruby-5354.html) by Peter Cooper over at [Ruby Inside](http://rubyinside.com/).

A tutorial on [writing your own MiniTest::Spec expectations](https://gist.github.com/2032303).

Vim [syntax highlighting](https://github.com/sunaku/vim-ruby-minitest) for MiniTest.
