
require 'rubygems'
require 'jekyll-import'

blog = ENV["BLOG"]

JekyllImport::Importers::WordPress.run({
  "dbname"   => blog,
  "user"     => blog,
  "password" => blog,
  "host"     => "notorious",
  "socket"   => "3306",
  "table_prefix"   => "wp_",
  "site_prefix"    => "",
  "clean_entities" => true,
  "comments"       => true,
  "categories"     => true,
  "tags"           => true,
  "more_excerpt"   => true,
  "more_anchor"    => true,
  "extension"      => "html",
  "status"         => ["publish"]
})
