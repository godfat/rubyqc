# RubyQC [![Build Status](https://secure.travis-ci.org/godfat/rubyqc.png?branch=master)](http://travis-ci.org/godfat/rubyqc)

by Lin Jen-Shin ([godfat](http://godfat.org))

## LINKS:

* [github](https://github.com/godfat/rubyqc)
* [rubygems](https://rubygems.org/gems/rubyqc)
* [rdoc](http://rdoc.info/github/godfat/rubyqc)

## DESCRIPTION:

RubyQC -- A conceptual [QuickCheck][] library for Ruby.

It's not a faithful port since Hsakell is totally different than Ruby.
However it's still benefit to use some of the ideas behind QuickCheck,
and we could also use RubyQC for generating arbitrary objects.

[QuickCheck]: http://en.wikipedia.org/wiki/QuickCheck

## WHY?

How do we make sure our programs work as expected?
Taking it to the extreme, of course we prove it formally.
We have [Agda][] for Haskell people, or [Coq][] for OCaml people.

However, in most cases we don't really care if they are
100% correct. Do we care PRNGs are really random
in games? Some people might care, we don't. Can we
prove halting problem? Of course not, but we do need
termination check at times.

For most cases, an army of tests is far good enough.
Usually we write scenario based tests. We first assume
things, and then do things, finally verify results. This is
quite simple, but cannot really cover most of the inputs
without great effort.

QuickCheck took another approach. Instead of writing
scenario, we think about what properties do our programs,
or functions have, giving a range of inputs. Suppose
we want to test the reverse function, instead of testing
against a fixed set of lists and verify a fixed set of results,
we think about what properties does reverse have.

For example, if we reverse and reverse a list, the result
should be equal to the original list. With QuickCheck, it
could then generate arbitrary random lists to the property
function you just wrote, and verify if the property holds.
By default, it would generate 100 test cases.

This approach would force you think more about the
precondition and postcondition, eliminating unusual
corner cases you might never think of, and force you
think what are the functions we're really writing. We
could also raise the number of test cases by configuring
it and raise our level of confidence about correctness.

[Agda]: http://en.wikipedia.org/wiki/Agda_%28programming_language%29
[Coq]: http://en.wikipedia.org/wiki/Coq

## DESIGN:

* Testing framework agnostic
* Therefore RubyQC could be treated as an arbitrary object generator library
* Think about [combinator][]
* Self hosted (Test RubyQC with RubyQC!)

[combinator]: http://en.wikipedia.org/wiki/Combinator_library

## REQUIREMENTS:

* Tested with MRI (official CRuby), Rubinius and JRuby.

## INSTALLATION:

    gem install rubyqc

## SYNOPSIS:

### RubyQC::API.check

Here's a quick example using [Bacon][]. We check if `Array#sort` has the
property that the front elements of the result array would be `<=` than
the rear elements of the result array for all arrays.

``` ruby
require 'bacon'
require 'rubyqc'

Bacon.summary_on_exit
include RubyQC::API

describe Array do
  describe 'sort' do
    should 'Any front elements should be <= any rear elements' do
      check([Fixnum]*100).times(10) do |array|
        array.sort.each_cons(2).each{ |x, y| x.should <= y }
      end
    end
  end
end
```

[Bacon]: https://github.com/chneukirchen/bacon

Basically, `RubyQC::API.check` would merely take the arguments and
generate the instances via `rubyqc` method. Here the generated array
could be viewed as `([Fixnum]*100).rubyqc`, meaning that we want an
array which contains 100 random instances of Fixnum.

As you can see, here actually `rubyqc` is an instance method of Array,
and it would recursively call `rubyqc` for all elements of the array,
and collect the results. Here's the definition of `Array#rubyqc`:

``` ruby
class Array
  def rubyqc
    map(&:rubyqc)
  end
end
```

And `Fixnum.rubyqc` is a Fixnum's singleton method which is defined as
follows:

``` ruby
class Fixnum
  def self.rubyqc
    rand(RubyQC::FixnumMin..RubyQC::FixnumMax)
  end
end
```

You get the idea.

### RubyQC::API.forall

Other than `check`, we also have `forall` which would iterate through all the
possible choices in case you would simply like to test all combinations.
Here's an example for checking compare_by_identity:

``` ruby
describe Hash do
  describe 'compare_by_identity' do
    should 'Treat diff str with the same contents diff when set' do
      str = 'str'
      forall([true, false], [str, 'str'], [str, 'str']) do |flag, a, b|
        h = {}
        h.compare_by_identity if flag
        h[a] = h[b] = true

        if (flag && a.object_id != b.object_id) || a != b
          h.size.should == 2
        else
          h.size.should == 1
        end
      end
    end
  end
end
```

### Kernel generator

The very default generator would simply return the instance itself.
So if there's no generator defined for a given class or instance, it
would merely take `self`.

``` ruby
true.rubyqc # true
```

### Class generator

This default generator for classes would simply return a new instance via
`new` method. This could fail if the `initialize` method for the particular
class does not take zero argument.

``` ruby
Object.rubyqc # kind_of?(Object)
```

### Fixnum, Bignum, and Integer generator

This would give you a random integer. Fixnum and Bignum would guarantee to
give you the particular class, whereas Integer would give you either a Fixnum
or Bignum.

``` ruby
Fixnum.rubyqc # kind_of?(Fixnum)
```

### array generator

We also have instance level generator, which was used in the first example.
The array instance generator would recursively call `rubyqc` for all elements
of the array, and collect the results.

``` ruby
[Fixnum, Fixnum].rubyqc # [kind_of?(Fixnum), kind_of?(Fixnum)]
```

### hash generator

This also applies to hashes which would do the same thing as arrays for the
values, keeping the key.

``` ruby
{:fixnum => Fixnum}.rubyqc # {:fixnum => kind_of?(Fixnum)}
```

### range generator

Fixnum would actually give a very large or very small (negative) number in
most cases. If you want to have a number with specific range, use a range
object to specific the range.

``` ruby
(1..6).rubyqc # within?(1..6)
```

Granted that this is actually the same as using `rand(1..6)`, but for
combinators we need to have a unified interface.

### Define your own generator

Just define `rubyqc` method for your classes or instances. This weird name
was simply chosen to avoid name conflicting since we don't have [typeclass][]
in Ruby, and it's quite natural to open and insert new methods into classes
in Ruby. Here's a quick example:

``` ruby
class User < Struct.new(:id, :name)
  def self.rubyqc
    new(Fixnum.rubyqc, String.rubyqc)
  end
end

describe 'User.rubyqc' do
  should 'Generate random users' do
    check(User) do |user|
      user     .should.kind_of User
      user.id  .should.kind_of Fixnum
      user.name.should.kind_of String
    end
  end
end
```

[typeclass]: http://learnyouahaskell.com/types-and-typeclasses

### Implementation reference

[QuickCheck.hs](http://www.cse.chalmers.se/~rjmh/QuickCheck/QuickCheck.hs)

## CONTRIBUTORS:

* Lin Jen-Shin (@godfat)

## LICENSE:

Apache License 2.0

Copyright (c) 2014, Lin Jen-Shin (godfat)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
