% Introduction to the Elixir Programming Language - Notes
% George Lesica
% June 2014

# About me

# Disclaimer

I realize that it makes sense to talk about things you know a lot about, but one
way to learn something new is to promise to give a talk on it, quite a good
motivator. In any event, I've been a fan of Erlang for several years now and
I've played with Elixir quite a bit casually, so I think I'm qualified to give
an introductory talk. That being said, if you find any errors, pull requests and
comments are always welcome!

# About the talk


# A brief history of Erlang

Erlang was originally developed at Ericsson in 1986 by Joe Armstrong. It was
used internally starting in the mid 1990s to build telephony products with
extremely high availability (nine "9s"). In 1998 the OTP system was open sourced
as the Open Telecom Protocol, this includes the Erlang compiler and runtime and
several additional components that can be used to build highly concurrent,
fault-tolerant systems.

The language remained fairly niche for several years but has gained in
popularity as demand for highly concurrent, distributed systems has grown.

# Erlang, what is it good for?

The Erlang virtual machine (BEAM) supports extremely lightweight processes,
which, when combined with single-assignment (immutability) make concurrency a
relatively simple task (as compared to languages that require the use of threads
and explicit locks or other concurrency primitives). Erlang employs the actor
model of concurrency, which follows the "share by communicating, don't
communicate by sharing" philosophy popularized more recently by Google Go.

Due in part to the single-assignment property, an Erlang system can actually
have its code hot-swapped without stopping the system. This allows extremely
high-availability systems to be constructed.

The design of the Erlang virtual machine prioritizes responsiveness over
throughput. This allows soft real-time systems to be built using the language.
This also means that Erlang is not well-suited for situations where raw
throughput is desirable (such as scientific computing).

Many of the strengths that Erlang inherited from its telecommunications industry
roots make it perfect for modern Internet development. Mobile back-ends, chat
systems, and web applications are all good candidates for Erlang implementation.

# Elixir: Erlang's hip younger sibling

A common complaint about Erlang is that its syntax is confusing and difficult to
learn. While this is obviously a matter of personal style preference, it is true
that the syntax is unusual. Elixir will feel more familiar to most people,
especially those coming from languages like Python and Ruby.

# Elixir syntax - anonymous functions

Anonymous functions are especially useful in functional languages when used with
calls to `map`, `reduce`, and `filter` but they have other uses as well
(people who know JavaScript should feel right at home here).

# Elixir syntax - tuples

Tuples are stored contiguously in memory, so getting a specific element or the
size of the tuple is fast. Also, like other variables in Elixir, tuples are
immutable, so setting a particular element to a value returns a new tuple, it
does not alter the existing tuple.

# Elixir syntax - functions

Notice that there is no `return` statement. Expressions (things that evaluate to
some value) are extremely important in functional languages. Just about every
feature in Elixir is an expression rather than a statement. Functions are
expressions (you generally don't have `void` functions since you can't mutate
state) and the value of a function is the last expression in the function body.
This pattern has actually been adopted by some imperative languages as an
optional form as well, such as R and Julia.
