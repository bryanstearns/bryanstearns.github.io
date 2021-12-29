# frozen_string_literal: true
require "jekyll"

module TagTimeTotals
  class TagTimeTotals < Jekyll::Generator
    safe true

    DEFAULTS = {
      "categories" => {
      },
    }.freeze

    def initialize(config = {})
      totals_config = config.fetch("tag-time-totals", {})
      if totals_config.is_a?(Hash)
        @config = Jekyll::Utils.deep_merge_hashes(DEFAULTS, totals_config)
      else
        @config = nil
        Jekyll.logger.warn "TagTimeTotals:", "Expected a hash but got #{totals_config.inspect}"
        Jekyll.logger.warn "", "Tag time totals will not be generated for this site."
      end
    end

    def generate(site)
      return if @config.nil?

      totals = {}

      site.categories.each do |category, posts|
        tags = @config["categories"][category]
        if tags # it's a category we care about, so scan its posts
          posts.each do |post|
            collect_post_times(totals, category, post, tags)
          end
        end
      end

      site.data["tag_time_totals"] = site.config["tag-time-totals"] = totals
    end

    def collect_post_times(totals, category, post, tags)
      tags.each do |tag|
        if post.data.has_key?("times") && post.data["times"][tag]
          # This post has times to record for multiple tags
          record_time(totals, category, tag, post.data["times"][tag])
        elsif post.data.has_key?("time") && post.tags == [tag]
          # This post has a single time to record for this tag
          record_time(totals, category, tag, post.data["time"])
        end
      end
    end

    def record_time(totals, category, tag, time)
      totals[category] ||= {}
      totals[category][tag] = (totals[category][tag] || 0) + time
      totals[category]["Total"] = (totals[category]["Total"] || 0) + time
    end
  end
end
