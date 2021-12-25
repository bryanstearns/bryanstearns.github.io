---
published: true
title: Profiling a Slow Elixir Test
date: "2016-12-14 21:19:04 -0800"
---

I noticed that a couple of tests in my current Elixir project were a little
slow, so I set out to find a way to profile them... I quickly found this <a
href="http://learningelixir.joekain.com/profiling-elixir/">this
helpful blog post</a> (thanks, Joseph Kain!), and tried out <a
href="https://github.com/parroty/exprof">ExProf</a> &mdash; but afterward, like
Joseph said, "At this point I was a little confused by the results."

So I kept reading Joseph's post, wherein he tried out Erlang's <a
href="http://erlang.org/doc/man/fprof.html">`fprof`</a>. This looked better (as
he says) because `fprof` supports display of call chains, providing a lot more
useful context. Better still, I found <a
href="http://learningelixir.joekain.com/mix-profile/">his followup post</a> that
taught me about how recent versions of Elixir come with a Mix task (`mix profile.fprof`) for profiling that produces friendlier output.

The Mix task didn't give me an easy way to wrap a slow test, though: it's good
for measuring an easily-isolatable bit of code like a single function, but
sometimes tests involve setup that's harder to isolate... so I cooked up this
little macro and dropped it into my project's `test/test_helper.exs`:

```
defmodule FProf do
  defmacro profile(do: block) do
    content = quote do
      Mix.Tasks.Profile.Fprof.profile(fn -> unquote(block) end,
        warmup: false, sort: "acc", callers: true)
    end
    Code.compile_quoted(content)
  end
end
```

<!--more-->When I notice that a test runs slowly, I can temporarily wrap just the "meat" of

it (avoiding asserts extraneous stuff like the ExVCR setup here) like this:

```
test "service gets a single movie" do
  use_cassette "movie_finder", match_requests_on: [:query] do
    # assert MovieFinder.find(313369).title == "La La Land"
    profile do
      Movies.MovieFinder.find(313369)
    end
  end
end
```

I'm probably missing something here that I haven't figured out yet: though the
test module has `alias Movies.MovieFinder` in it, I had to use the full module
name in the `profile` block.

This code got me the answer I needed, though, so I've declared victory and moved
on: I found that though I'm using `ExVCR` to avoid hitting an external HTTP API
from my tests, my rate-limiter module, which I use to avoid hammering the
external API, was sometimeskicking in. I fixed it by configuring a dummy
rate-limiter module in the test environment.
