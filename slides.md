% Introduction to the Elixir Programming Language
% George Lesica
% June 2014

# About me

  * Software developer
  * Graduate student
  * Programming language hipster
  * Contact me
    * george@lesica.com
    * Web: <http://lesica.com>
    * GitHub: [glesica](http://github.com/glesica)
    * Twitter: [glesica](http://twitter.com/glesica)

# Disclaimer

  * I am not an expert

# About the talk

I'm going to try to cover a lot of ground. This is just an intro, there won't be
a ton of depth. The goal is to show you enough that you can play around with it
and decide if you want to use it.

  * The Erlang ecosystem
  * Functional programming
  * Elixir syntax and style
  * Demo code

# Demo app - tcpchat

Code: <https://github.com/glesica/tcpchat>

Demo: `telnet 107.170.185.125 4000`

# A brief history of Erlang

  * Developed at Ericsson in 1986
  * Designed for telephony systems
  * Proprietary until 1998
  * Growing popularity
    * Amazon
    * Call of Duty
    * GitHub
    * Goldman Sachs
    * Heroku
    * WhatsApp

# Erlang, what is it good for?

  * Concurrency
  * Fault-tolerance
  * Soft real-time

# How Erlang does concurrency

  * Scheduler per thread
  * BEAM processes are super lightweight (less than 1K)
  * Schedulers can preempt BEAM processes
    * Process gets 2000 "reductions"
    * Everything (basically) costs reductions
    * Sending messages to full mailboxes is more expensive
  * Example: 100 things to do, first one will take 50 ms, the rest will be fast,
    in other languages job 2 would take at least 50 ms, in Erlang job 1 gets
    preempted.
  * Node.js attempts to do this but it doesn't work if you do any computation

# Actor model

Erlang uses the actor model for concurrency:
<https://en.wikipedia.org/wiki/Actor_model>

  * Processes are actors
  * Each process has a mailbox (queue)
  * Messages are sent using PIDs
    * Sending a message costs reductions
    * Messages sent asynchronously
  * Eliminates (largely) the need for callbacks
    * Common pattern: `send(pid, {:message, self()})`
    * Receiver replies to variable bound to `self()`

More on this when we look at the demo application!

# Elixir: Erlang's hip younger sibling

  * Friendlier syntax (similar to Ruby)
  * Unicode support baked-in
  * Modern tool chain (Mix)

# Functional programming

  * Everything is a function
    * Inputs map to outputs
    * Given inputs guarantee the same outputs
    * Emphasis on pure functions - no side effects
  * Variables can't be reassigned (immutability)
  * Lots of recursion

# Immutability: why would I want that?

Immutability makes code more predictable, easier to reason about and understand.

  > Is there a way I can have browser dev tools breakpoint every time a variable
  > changes value? It'd be like console.breakOnChange(this.context)
  >
  > Source: <https://twitter.com/pamelafox/status/472416563950153728>

# Example: loop

  * Classic operation
  * Imperative way to do it
  * Functional way to do it
  * Using Python (since it is basically pseudo code and many people know it)

# Example: counter loop

Classic C-style loop most of us learned first. We mutate state in order to loop.
We change the value of `i` and the values stored in the elements of `outlist`.

~~~python
def square(inlist):
    outlist = [0] * len(inlist)
    for i in range(len(inlist)):
        outlist[i] = inlist[i] ** 2
    return outlist
~~~

# Example: iterator loop

More modern iteration. We no longer rely on mutating a counter and looping as a
side effect. The loop is explicit and therefore safer, but we still have state
since `outlist` grows as the loop runs. This could be a source of bugs.

~~~python
def square(inlist):
    outlist = []
    for i in inlist:
        outlist.append(i ** 2)
    return outlist
~~~

# Example: recursive loop

We can simulate a loop using recursion. Note that we could optimize this further
using tail recursion, but Python doesn't support it anyway (Elixir does).

~~~python
def square(inlist):
    if len(inlist) == 0:
        return []
    head = inlist[0]
    tail = inlist[1:]
    return [head ** 2] + square(tail)
~~~

# Example: map loop

This would be the One True way to solve this problem functionally. Note that
quite a few modern languages support, or have added support, for the map
operation in recent years. Note the complete lack of state.

~~~python
def square(inlist):
    return map(lambda x: x ** 2, inlist)
~~~

We could even use a comprehension instead (another increasingly popular
functional concept).

~~~python
def square(inlist):
    return [x ** 2 for x in inlist]
~~~

# Advantages

  * Safer concurrency
    * Can't change data anyway
    * Predictable results from functions
  * Fewer bugs
    * Harder to accidentally violate assumptions or invariants
    * Testing is generally easier

# Elixir syntax

  * Brief overview
  * Code organization
  * Control flow
  * Variables
  * Data structures

# Elixir syntax - REPL

  * To run the REPL:

~~~bash
$ iex
~~~

  * Some simple examples (more in a moment):

~~~elixir
iex(1)> 375 * 3492
1309500
iex(2)> [1, 3, 5] ++ [7, 9, 11]
[1, 3, 5, 7, 9, 11]
iex(3)> {"hello", "there"}
{"hello", "there"}
iex(4)> :atom
:atom
~~~

# Elixir syntax - types

We have a fairly simple type system in Elixir:

  * `:atom` - atoms, like Ruby symbols, memory efficient
  * `"hello world"` - binary strings
  * `'hello world'` - character lists (for Erlang inter-op)
  * `73` - integers
  * `3.14` - floats

There are some other, more specialized types as well.

# Elixir syntax - pattern matching

Pattern matching can look like assignment, but it really isn't and it is used in
many more situations (stay tuned).

~~~elixir
iex(1)> a = 1
1
iex(2)> {b, c} = {2, 3}
{2, 3}
iex(3)> c
3
iex(4)> {1, d} = {1, 4}
{1, 4}
iex(5)> d
4
iex(6)> {1, e} = {2, 5}
** (MatchError) no match of right hand side value: {2, 5}
~~~

# Elixir syntax - if-else

If statements aren't statements, they are expressions that evaluate to the value
of the chosen clause.

~~~elixir
a = 4
b = if a < 5
  "a is less than 5"
else
  "a is not less than 5"
end
~~~

# Elixir syntax - case

Similar to `if` in that it is an expression, it also allows pattern
matching.

~~~elixir
a = {1, 2}
case a do
  {1, c} -> c
  {2, c} -> c * 2
end
~~~

# Elixir syntax - anonymous functions

Anonymous functions can be defined easily, the `.` syntax is required to call
them.

~~~elixir
iex(1)> double = fn x -> 2 * x end
#Function<6.106461118/1 in :erl_eval.expr/5>
iex(2)> double.(5.5)
11.0
~~~

**Note**: anonymous functions are closures, so you can accept variables in-scope
where the function is defined.

# Elixir syntax - anonymous functions (short syntax)

Short syntax is shorter (obviously) but perhaps harder to read.

~~~elixir
iex(1)> triple = &(3 * &1)
#Function<6.106461118/1 in :erl_eval.expr/5>
iex(2)> triple.(4)
12
~~~

# Elixir syntax - lists

Lists are implemented as linked lists (makes sense when you think about
recursively processing lists).

~~~elixir
iex(1)> a = [1,2,3]
[1, 2, 3]
iex(2)> b = [4,5,6]
[4, 5, 6]
iex(3)> a ++ b
[1, 2, 3, 4, 5, 6]
iex(4)> length a
3
iex(5)> hd a
1
iex(6)> hd []
** (ArgumentError) argument error
    :erlang.hd([])
~~~

# Elixir syntax - tuples

Tuples are similar to Python but with pattern matching (woo!).

~~~elixir
ex(1)> greeting = {:hello, "Hi there, friend!"}
{:hello, "Hi there, friend!"}
iex(2)> {:hello, text} = greeting
{:hello, "Hi there, friend!"}
iex(3)> text
"Hi there, friend!"
iex(4)> set_elem greeting, 1, "Hello!"          
{:hello, "Hello!"}
iex(5)> greeting
{:hello, "Hi there, friend!"}
iex(6)> get_elem greeting, 1
"Hi there, friend!"
~~~

**Note**: notice that tuples are immutable.

# Elixir syntax - pipes

Elixir allows function chaining similar to Unix pipes. This is a very powerful
technique we'll look at more later.

~~~elixir
iex(18)> " hello there" |> String.strip |> String.split(" ")                                  
["hello", "there"]
~~~

# Elixir syntax - functions

First, the identity function, it just returns its argument, unaltered.

~~~elixir
def identity(arg) do
  arg
end
~~~

# Elixir syntax - modules

Functions go inside modules, use modules to organize your code.

~~~elixir
defmodule Identity do
  def identity(arg) do
    arg
  end
end
~~~

# Elixir syntax - module attributes

These can be (and are) used for documentation or as constants.

~~~elixir
defmodule Maths do
  @moduledoc """
  Some awesome math functions!
  """

  @pi 3.1415

  def circle_area(radius)
    radius * radius * @pi
  end
end
~~~

# Elixir syntax - maps

Maps are associative arrays that map keys on to values. If the keys are atoms
(which is a good idea) we can use a very concise syntax.

~~~elixir
iex(1)> m = %{name: "George", disposition: "Grumpy"}
%{disposition: "Grumpy", name: "George"}
iex(2)> m[:name]
"George"
iex(3)> d = %{1 => 2, 2 => 4, 3 => 6}
%{1 => 2, 2 => 4, 3 => 6}
iex(4)> d[1]
2
~~~

# Elixir syntax - maps (cont'd)

We can have mixed type keys, but we use the fat arrow syntax in that case. We
can also pattern match on them to pull out specific values.

~~~elixir
iex(5)> r = %{:name => "George", "lastname" => "Lesica"}
%{:name => "George", "lastname" => "Lesica"}
iex(6)> r["lastname"]
"Lesica"
iex(7)> r[:name]
"George"
iex(8)> %{name: name} = r
%{:name => "George", "lastname" => "Lesica"}
iex(9)> name
"George"
~~~

# Elixir syntax - comprehensions

~~~elixir
iex(1)> for n <- [1, 2, 3, 4], do: n * n
[1, 4, 9, 16]
iex(2)> for n <- 1..4, do: n * n
[1, 4, 9, 16]
iex(3)> require Integer
nil
iex(4)> for n <- 1..4, Integer.odd?(n), do: n * n
[1, 9]
~~~

**Note**: We had to `require Integer` because `odd` is a macro.

# Elixir syntax - other stuff

  * structs - maps with default values and compile-time checking
  * protocols - polymorphism (basically interfaces)
  * cond, unless
  * error handling

# Sample code!

Take a look at the demo project. Note that this isn't necessarily a good way to
do what I've done, but it is simple and illustrates Elixir/Erlang concepts
reasonably well.

  * <https://github.com/glesica/tcpchat>

# Elixir references

  * <http://elixir-lang.org> - language web site, including downloads and an
    excellent tutorial
  * <http://elixirsips.com/> - short tutorial videos demonstrating key features
    of Elixir and various Erlang libraries it can use

# Thank you!

Questions or comments, contact me!

  * george@lesica.com
  * @glesica
