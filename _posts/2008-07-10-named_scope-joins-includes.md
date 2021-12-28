---
published: true
title: named_scope, joins, & includes
date: "2008-07-10 13:51:25 -0700"
category: Coding
---

I used Rails 2.1's named_scope to implement various ways to sort things on <a href="http://osoeco.com">OsoEco</a>. When I
implemented "most discussed" on the Question model (questions have many
comments), it involved joining in the comments table to count comments for each
question.<!--more--> Initially, it looked something like:

<!-- prettier-ignore-start -->
{% highlight ruby %}
named_scope :most_active, :joins => :comments, :group => "questions.id",
            :order => "count(questions.id) desc"
{% endhighlight %}
<!-- prettier-ignore-end -->

That caused a problem, which the Pivotal Labs folks also <a href="http://pivots.pivotallabs.com/users/joe/blog/articles/465-standup-07-10-2008">commented on today:</a>

> When using `named_scope`, adding a `:joins` option will "mix-in" all of the
> attributes from that join table into your retrieved object, potentially
> overwriting any colliding attributes (including `id` ... ouch!). There was
> consensus that this was a valuable feature, when used "properly". Adding
> `:select` option can avoid this, or use `:include`.

Like they said, I fixed this with `:select` -- the second try looked like
this:

<!-- prettier-ignore-start -->
{% highlight ruby %}
named_scope :most_active, :select => "questions.*", :joins => :comments,
            :group => "questions.id", :order => "count(questions.id) desc"
{% endhighlight %}
<!-- prettier-ignore-end -->

That worked (and fixed that problem), but it occurred to me that if my
controller wanted to `:include` additional tables to add onto this scope (and
that's one of the cool things that `named_scope` enables), it wouldn't work:
`Question.most_active.scoped(:include => :comments)` raises a bad-SQL exception.

Fixing this required a bit of table aliasing, and led to this:

<!-- prettier-ignore-start -->
{% highlight ruby %}
named_scope :most_active, :select => "questions.*",
            :joins => "left join comments as comments_for_count on
                       comments_for_count.question_id = questions.id",
            :group => "questions.id",
            :order => "count(questions.id) desc"
{% endhighlight %}
<!-- prettier-ignore-end -->

This worked, even with the `:include` added in a subsequent (anonymous) scope.
