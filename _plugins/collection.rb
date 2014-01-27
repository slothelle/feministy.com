require 'yaml'

class RavelryCollection
  def initialize(opts)
    @purchase_link = opts[:purchase_link]
    @price = opts[:price]
    @permalink = opts[:permalink]
    @category = opts[:category]
  end

  def create_file
    read_yaml_file
    join_yaml_result
    create_file_contents
    create_file_from_contents
  end

  def filename
    @filename = "collections/#{@permalink}/index.html"
  end

  private
  def read_yaml_file
    @yml_file = YAML.load_file('_plugins/collection.yml')
  end

  def join_yaml_result
    @yml = @yml_file.join("\n")
  end

  def pretty_collection_name
    title = @permalink.gsub(/\-/, ' ').split
    title.map { |t| t.capitalize }.join(" ")
  end

  def collection_images
    "<p><img src='{{ post.images[0] }}'></p>\n"
  end

  def meta_spacer
    "---\n"
  end

  def meta_layout
    "layout: default\n"
  end

  def meta_title
    "title: 'feministy.com - #{pretty_collection_name}'\n"
  end

  def meta_purchase_info
    "price: '#{@price}'\nperma: '#{@permalink}'\npurchase_link: '#{@purchase_link}'\n"
  end

  def hero_unit
    "<h1>#{pretty_collection_name} <a href='{{ page.purchase_link }}' class='btn btn-success'>{{ page.price }} &bull; Buy collection now!</a></h1>\n<hr>\n"
  end

  def closing_hero_unit
    "<a href='{{ page.purchase_link }}' class='btn btn-success btn-large btn-block'>{{ page.price }} &bull; Buy #{pretty_collection_name} now!</a>"
  end

  def open_liquid_for
    "{% for post in site.categories.#{@category} %}\n"
  end

  def end_liquid_for
    "{% endfor %}\n"
  end

  def create_file_contents
    @contents = meta_spacer + meta_layout + meta_title + meta_purchase_info + meta_spacer + hero_unit
    @contents = @contents + open_liquid_for + @yml + end_liquid_for + closing_hero_unit
  end

  def create_file_from_contents
    File.open(filename, "w") { |file| file.write(@contents) }
    puts "#{filename} created."
  end

  def div_pull_right(content)
    "<div class='pull-right'>\n#{content}</div>\n"
  end
end

collections = []

collections << RavelryCollection.new(
  purchase_link: 'http://www.ravelry.com/purchase/feministy/97506',
  price: '$16.00',
  permalink: 'arch-shawls',
  category: 'arch'
  )
collections << RavelryCollection.new(
  purchase_link: 'http://www.ravelry.com/purchase/feministy/98461',
  price: '$24.00',
  permalink: 'great-cowl-kal-12',
  category: 'great'
  )
collections << RavelryCollection.new(
  purchase_link: 'http://www.ravelry.com/purchase/feministy/50578',
  price: '$12.00',
  permalink: 'funke-socks',
  category: 'funke'
  )
collections << RavelryCollection.new(
  purchase_link: 'http://www.ravelry.com/purchase/feministy/52290',
  price: '$20.00',
  permalink: 'traveling-woman',
  category: 'traveling'
  )
collections << RavelryCollection.new(
  purchase_link: 'http://www.ravelry.com/purchase/feministy/73365',
  price: '$20.00',
  permalink: 'fairy-tales-saga',
  category: 'fairy'
  )