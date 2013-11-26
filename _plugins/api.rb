require 'rubygems'
require 'json'
require 'curb'

pattern_ids = ["419443", "382813", "379890", "333038", "350319", "209052", "210188", "303053", "311429", "313002", "309557", "311149", "303654", "305054", "205477", "300500", "296623", "284798", "265288", "260602", "260597", "260599", "260601", "256055", "239686", "238330", "230385", "228861", "231799", "215962", "215959", "215960", "183821", "212415", "211464", "183819", "197320", "168971", "160632", "150257", "136176", "120739", "122624", "114680", "109435", "107235", "104642"]
pattern_ids.sort!

class RavelryPattern
  def initialize(id)
    @id = id
    do_all_the_things
  end

  def do_all_the_things
    api_call
    fetch_variables
    format_date
    format_sources if sources?
    format_categories
    format_needles
    format_yarns
    format_images
    format_free if online? && free?
    format_price if online? && !free?
    if @collection
      collection_getters
      identify_collection
    end
    make_header
    make_content
    save_file
    completion_message
  end

  private
  def api_call
    c = Curl::Easy.new("https://api.ravelry.com/patterns/#{@id}.json")
    c.http_auth_types = :basic
    c.username = ENV['RAV_ACCESS_KEY']
    c.password = ENV['RAV_PERSONAL_KEY']
    c.perform
    result = JSON.parse(c.body_str)
    @pattern = result["pattern"]
  end

  def fetch_variables
    @ravelry_permalink = @pattern["permalink"]
    @sizes = @pattern["sizes_available"]
    @filename = "_posts/2013-10-01-#{@ravelry_permalink}.markdown"
    @title = @pattern["name"]
    puts @title
    @gauge = @pattern["gauge_pattern"]
    @gauge_description = @pattern["gauge_description"]
    @yardage_description = @pattern["yardage_description"]
    @yarn_weight_description = @pattern["yarn_weight_description"]
    @body = @pattern['notes_html']
  end

  def format_date
    date = Time.now
    @date = date.strftime("%Y-%m-%d %H:%M:%S")
  end

  def sources?
    return true if @pattern["printings"]
  end

  def format_sources
    sources = @pattern["printings"]
    sources.each do |pub|
      if pub["primary_source"] == true && pub["pattern_source"]["name"] != "Feministy.com"
        @collection_name = pub["pattern_source"]["name"]
        @collection = "collection: '#{@collection_name}'\n"
      end
    end
  end

  def format_categories
    categories = @pattern['pattern_type']['name']
    if categories == "Shawl/Wrap"
      @categories = ["shawls"]
    else
      @categories = [categories.downcase]
    end
    @categories << "pattern"
  end

  def format_needles
    needles = @pattern["pattern_needle_sizes"].map do |needle|
      "#{needle['name']}"
    end
    @needles = needles.join("\n")
  end

  def format_yarns
    yarns = @pattern['packs'].map do |yarn|
      "#{yarn['yarn_name']} (#{yarn["yarn_weight"]["name"]})"
    end
    @yarns = yarns.join("\n")
  end

  def format_images
    @images = @pattern['photos'].map do |photo|
      photo["medium_url"]
    end
    @tiny_images = @pattern['photos'].map do |photo|
      photo["square_url"]
    end
    @image = @tiny_images[0]
  end

  def online?
    @pattern["download_location"]
  end

  def free?
    @pattern["download_location"]["free"] == true
  end

  def format_price
    @get_pattern = "price: '$#{@pattern["price"]}0'\npurchase_link: '#{@pattern["download_location"]["url"]}'\n"
  end

  def format_free
    @get_pattern = "free: yes\ndownload_link: #{@pattern["download_location"]["url"]}\n"
  end

  def make_header
    spacer = "---"
    meta = "\nlayout: pattern\ndate: #{@date}\nravelry_permalink: 'http://www.ravelry.com/patterns/library/#{@ravelry_permalink}'\n"
    title = 'title: "' + @title + '"' + "\n"
    cats = "categories: #{@categories}\n"
    ndls = "needles: '#{@needles}'\n"
    sizes = "sizes: #{[@sizes]}\n"
    gauge = "gauge: '#{@gauge}'\ngauge_description: '#{@gauge_description}'\n"
    yarn = "yarns: '#{@yarns}'\nyarn_weight_description: '#{@yarn_weight_description}'\nyardage_description: '#{@yardage_description}'\n"
    images = "images: #{@images}\ntiny_images: #{@tiny_images}\nimage: '#{@image}'\n"
    @header = spacer + meta + title + cats + ndls + sizes + yarn + gauge + images

    if @get_pattern
      @header  = @header + @get_pattern
    end

    if @collection
      @header = @header + @collection + @collection_purchase_link + @collection_price + @collection_permalink
    end

    @header = @header + spacer + "\n"
  end

  def make_content
    @content = @header + @body
  end

  def save_file
    File.open(@filename, "w") { |file| file.write(@content) }
  end

  def completion_message
    puts "#{@filename} created."
  end

  def collection_getters
    @collection_purchase_link = "collection_purchase_link: "
    @collection_price = "collection_price: "
    @collection_permalink = "collection_permalink: "
  end

  def identify_collection
    if @collection.include?('Arch')
      @categories << "arch"
      @collection_permalink = @collection_permalink + "arch-shawls \n"
      @collection_price = @collection_price + "$16.00 \n"
      @collection_purchase_link = @collection_purchase_link + "http://www.ravelry.com/purchase/feministy/97506 \n"
    elsif @collection.include?('Great')
      @categories << "great"
      @collection_permalink = @collection_permalink + "great-cowl-kal-12 \n"
      @collection_price = @collection_price + "$24.00 \n"
      @collection_purchase_link = @collection_purchase_link + "http://www.ravelry.com/purchase/feministy/98461 \n"
    elsif @collection.include?('Socks')
      @categories << "funke"
      @collection_permalink = @collection_permalink + "funke-socks \n"
      @collection_price = @collection_price + "$12.00 \n"
      @collection_purchase_link = @collection_purchase_link + "http://www.ravelry.com/purchase/feministy/50578 \n"
    elsif @collection.include?('Traveling')
      @categories << "traveling"
      @collection_permalink = @collection_permalink + "traveling-woman \n"
      @collection_price = @collection_price + "$20.00 \n"
      @collection_purchase_link = @collection_purchase_link + "http://www.ravelry.com/purchase/feministy/52290 \n"
    elsif @collection.include?('Fairy')
      @categories << "fairy"
      @collection_permalink = @collection_permalink + "fairy-tales-saga \n"
      @collection_price = @collection_price + "$20.00 \n"
      @collection_purchase_link = @collection_purchase_link + "http://www.ravelry.com/purchase/feministy/73365 \n"
    else
      @collection = nil
    end
  end
end

pattern_ids.each do |id|
  RavelryPattern.new(id)
end
