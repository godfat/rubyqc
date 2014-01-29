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

[combinator]: http://en.wikipedia.org/wiki/Combinator_library

## REQUIREMENTS:

* Tested with MRI (official CRuby) 2.0.0, 2.1.0, Rubinius and JRuby.

## INSTALLATION:

    gem install rubyqc

## SYNOPSIS:

Here's a quick example using [Bacon][].

``` ruby
require 'bacon'
require 'rubyqc'

include RubyQC::API

describe Array do
  describe 'sort' do
    should 'Any front elements should be <= any rear elements' do
      check([Fixnum]*100).times(100) do |array|
        array.sort.each_cons(2).each{ |x, y| x.should <= y }
      end
    end
  end
end

Bacon.summary_on_exit
```

[Bacon]: https://github.com/chneukirchen/bacon

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
