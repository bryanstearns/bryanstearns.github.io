# My blog

Since I almost never post, I usually forget how to:

- Create the new post file in `_posts`; any new images go in `images`, subdirectoried by the current year.
  Be sure to set the date correctly, and `published: true`, in the metadata at the top of each post.

- Serve the blog locally with `jekyll serve`; make sure things look good.

- Commit the new post files (and images, etc)

- Run `bundle exec rake blog:publish` to regenerate the site and push it to Github Pages (by putting the
  generated site in the `gh-pages` branch). (We have to generate the site locally because we use Jekyll
  plugins, which Github Pages won't use if it generates the site.)
