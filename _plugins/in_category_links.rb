# frozen_string_literal: true
require "jekyll"

module InCategoryLinks
  class InCategoryLinks < Jekyll::Generator
    safe true

    DEFAULTS = {}.freeze

    def initialize(config = {})
      links_config = config.fetch("in-category-links", {})
      if links_config.is_a?(Hash)
        @config = Jekyll::Utils.deep_merge_hashes(DEFAULTS, links_config)
      else
        @config = nil
        Jekyll.logger.warn "InCategoryLinks:", "Expected a hash but got #{links_config.inspect}"
        Jekyll.logger.warn "", "in-category links will not be generated for this site."
      end
    end

    def generate(site)
      return if @config.nil?

      site.categories.each do |category, posts|
        prev_post = next_post = nil
        posts.each_with_index do |post, index|
          post.data["previous_in_category"] = index > 0 && posts[index - 1] || nil
          post.data["next_in_category"] = index <= posts.count && posts[index + 1] || nil
        end
      end
    end
  end
end
