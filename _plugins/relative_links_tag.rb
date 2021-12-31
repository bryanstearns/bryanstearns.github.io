module Jekyll
  class RelativeLinksTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      page = context.environments.first['page']
      site = context.registers[:site]

      all_posts = site.posts.docs
      category_posts = find_category_posts(site, page)
      prev_all, next_all = next_prev(all_posts, page.id)
      prev_in_category, next_in_category = next_prev(category_posts, page.id)

      "<div class=\"rellinks\">\n" +
      block(:previous, prev_all, prev_in_category) +
        "<br/>" +
        block(:next, next_all, next_in_category) + "\n" +
        "</div>"
    end

    def block(mode, all_post, category_post)
      left_arrow = (mode == :previous) && (all_post || category_post) ? "←&nbsp;" : ""
      right_arrow = (mode == :next) && (all_post || category_post) ? "&nbsp;→" : ""

      same = all_post && category_post && all_post.id == category_post.id
      category_label = !same && category_post ? "#{category_post.data["categories"].first}: " : ""
      all_label = !same && all_post ? "All: " : ""

      category_link = category_post && post_link(category_label, category_post)
      all_link = !same && all_post && post_link(all_label, all_post)
      # category_link = category_post ? "<a href=\"#{category_post.url}\">#{category_post.data["title"]}</a>" : ""
      # all_link = !same && all_post ? "<a href=\"#{all_post.url}\">#{all_post.data["title"]}</a>" : ""

      links = [category_link, all_link].filter {|x| x}

      <<~BLOCK
      <div class="rellink #{mode}">
        #{left_arrow}
        <div>
        #{links.join("<br/>\n")}
        </div>
        #{right_arrow}
      </div>
      BLOCK
    end

    def next_prev(posts, post_id)
      post_index = posts.find_index {|p| p.id == post_id }
      prev_post = post_index > 0 ? posts[post_index - 1] : nil
      next_post = (post_index + 1) < posts.count ? posts[post_index + 1] : nil
      [prev_post, next_post]
    end

    def find_category_posts(site, page)
      site.categories[page.categories.first].reverse || []
    end

    def post_link(label, post)
      "#{label}<a href=\"#{post.url}\">#{post.data["title"]}</a> <time>(#{post.date.strftime("%b %-d, %Y")})</time>"
    end

    def show_posts(posts, prev_post, post, next_post)
      posts.map do |p|
        case p.id
        when post && post.id
          "<strong>post: #{p.date} #{p.url}</strong>"
        when prev_post && prev_post.id
          "<strong>prev: #{p.date} #{p.url}</strong>"
        when next_post && next_post.id
          "<strong>next: #{p.date} #{p.url}</strong>"
        else
          "#{p.date} #{p.url}"
        end
      end.join("<br/>\n")
    end
  end
end

Liquid::Template.register_tag('relative_links', Jekyll::RelativeLinksTag)

# <div class="rellinks previous">
#   {% if page.previous or page.previous_in_category %}← {% endif %}
#   <div>
#     {% if page.previous %}
#     <a href="{{ page.previous.url }}">
#       {% if page.previous_in_category %}All: {% endif %} {{ page.previous.title }}
#     </a>
#     <br />
#     {% endif %} {% if page.previous_in_category %}
#     <a href="{{ page.previous_in_category.url }}">
#       {% if page.previous_in_category %}In {{ page.category }}: {% endif %} {{
#       page.previous_in_category.title }}
#     </a>
#     {% endif %}
#   </div>
# </div>
