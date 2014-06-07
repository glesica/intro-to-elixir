% Introduction to the Elixir Programming Language - Notes
% George Lesica
% June 2014

# About these notes

All the headings after this one refer directly to slides in my presentation of
the same title. These notes are for my own benefit during the talk, but also for
the benefit of anyone who would like the understand the slides a little better
after-the-fact. I hate when people dump cryptic slides online as though they are
useful to anyone, so I try not to do that.

# About me

I'm George! I'm a graduate student in computer science at the University of
Montana and a software developer. I have an interest in distributed systems and
I've been casually interested in Erlang and Elixir for several years now. I am
also a bit of a functional programming fanboy, so the whole thing is a pretty
natural fit.

I have a random academic background. I have a BA in political
science that I followed up with an MA in economics. Then I worked for awhile
before deciding that I couldn't live without an MS in computer science (I had
most of a BS in math/CS already).

# Disclaimer

I realize that it makes sense to talk about things you know a lot about, but one
way to learn something new is to promise to give a talk on it, quite a good
motivator. In any event, I've been a fan of Erlang for several years now and
I've played with Elixir quite a bit casually, so I think I'm qualified to give
an introductory talk. That being said, if you find any errors, pull requests and
comments are always welcome!

# About the talk

This talk is going to be a pretty standard language talk for the most part. The
one exception to this pattern is that I am going to spend a decent amount of
time talking about why you would ever want to use Elixir. The reason for this is
twofold. First, Elixir runs on the same virtual machine as Erlang, which means
that it comes along with quite a bit of (as it turns out, good, very useful)
baggage, which many people are understandably apprehensive about, and isn't
entirely trivial to get up and going.

Second, Elixir is a functional programming language. Virtually all of us started
out lives as programmers with imperative programming languages and these
generally map nicely into easy metaphors about programming in general: you're
just giving the computer a series of instructions, just like you might to a
child or coworker. The problem (and we'll discuss a bit more in a minute) with
this is that imperative instructions don't scale very well. For instance, give
someone instructions for how to make an omelette, pretty simple. Now give two
people instructions to make one omelette (in a way that lets them do better than
one of them working alone), quite a bit harder!

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

# How Erlang does concurrency

http://jlouisramblings.blogspot.com/2013/01/how-erlang-does-scheduling.html

"When you call spawn(fun worker/0) a new process is constructed, by allocating
its process control block in userland. This usually amounts to some 600+ bytes
and it varies from 32 to 64 bit architectures. Runnable processes are placed in
the run-queue of a scheduler and will thus be run later when they get a
time-slice."

"Every once in a while, processes are migrated between schedulers according to a
quite intricate process. The aim of the heuristic is to balance load over
multiple schedulers so all cores get utilized fully. But the algorithm also
considers if there is enough work to warrant starting up new schedulers. If not,
it is better to keep the scheduler turned off as this means the thread has
nothing to do. And in turn this means the core can enter power save mode and get
turned off. Yes, Erlang conserves power if possible."

"Both processes and ports have a "reduction budget" of 2000 reductions. Any
operation in the system costs reductions. This includes function calls in loops,
calling built-in-functions (BIFs), garbage collecting heaps of that process[n1],
storing/reading from ETS, sending messages (The size of the recipients mailbox
counts, large mailboxes are more expensive to send to)."

# Elixir: Erlang's hip younger sibling

A common complaint about Erlang is that its syntax is confusing and difficult to
learn. While this is obviously a matter of personal style preference, it is true
that the syntax is unusual. Elixir will feel more familiar to most people,
especially those coming from languages like Python and Ruby.

# Example - iterator loop

There are a couple things going on here that could cause problems. First, if the
code wasn't so short, it would be relatively easy for someone to get confused
and try to mutate `outlist` as we're appending to it. Another potential problem
is that it could be returned early, the name says it all...  **out** -list. It's
the list we're going to send **out** of the function. If it isn't complete, then
why does it exist?

The solution to this is almost trivially obvious, right? Just make this process
atomic by encapsulating it in a function, class, library, whatever. That way no
one can screw around with it before we're finished doing what we need to do, and
no one can change the code based on an invalid assumption (like returning
`outlist` before it has been fully built). Sounds great, right? Congratulations,
you just invented the map function!

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
