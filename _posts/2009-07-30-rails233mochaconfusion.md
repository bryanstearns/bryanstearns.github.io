---
published: true
title: Rails 2.3.3 + mocha = confusion
date: "2009-07-30 15:48:22 -0700"
category: Coding
---

I just updated a project to <a href="http://weblog.rubyonrails.org/2009/7/20/rails-2-3-3-touching-faster-json-bug-fixes" target="blank">Rails 2.3.3</a>
for the cool new "touch" feature, and saw <a href="http://railspikes.com/2009/7/29/rails-2-3-3-upgrade-notes/" target="blank">here</a>
that I needed to update to Mocha 0.9.7. I did that, but found that my tests were
failing - I got lots of `NoMethodError: undefined method 'stub' for #<SomeTest:0x7f2c1d921f80>` errors.<!--more-->

In my project, I'd declared my dependence on the Mocha gem in my
`config/environment.rb` file, so that `sudo rake gems:install` would load
everything required for development in one shot (which is why the dependency
isn't in `config/environments/test.rb`). I'll cut to the chase: I needed to
add an extra :lib option to that declaration:

{% highlight ruby %}
config.gem 'mocha', :version => '=0.9.7', :lib => false
{% endhighlight %}

The problem is that mocha configures itself based on what test library you've
**already** included when you require Mocha. Unfortunately, the config.gem
declaration causes mocha to be loaded before Rails has loaded Test::Unit,
so Mocha doesn't configure itself... so no "stub." Setting `:lib` to `false`
postpones loading Mocha until you actually do it in your `test/test_helper.rb`
(or wherever).
