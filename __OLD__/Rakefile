require 'rubygems'
require 'active_support/inflector'

# rake new_post['title',YYYY-MM-DD]
desc "Create a new empty post file"
task :new_post, :title, :date, :image do |task, args|
  title = args.title
  date = args.date || Time.new.strftime("%Y-%m-%d")
  image = args.image || nil
  file_title = title.parameterize
  filename = "#{date}-#{file_title}.markdown"

  File.open("_posts/" + filename, "w") do |f|
    f.puts "---"
    f.puts "title: \"#{title}\""
    f.puts "layout: post"
    f.puts "date: #{date}"
    f.puts "categories: ['blog']"
    if image
      f.puts "image: '#{image}'"
    end
    f.puts "---"
  end

  puts "#{filename} created."
end