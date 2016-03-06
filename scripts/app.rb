require 'ravelry'
require 'pry'

pattern_urls = ["goodbye-california", "very-pdx-hat", "crenel-hat", "misdirected-cowl", "in-winter", "forest-park-cowl", "winter-sea-shawl-2"].reverse

pattern_ids = ["419443", "382813", "379890", "333038", "350319", "209052", "210188", "303053", "311429", "313002", "309557", "311149", "303654", "305054", "205477", "300500", "296623", "284798", "265288", "260602", "260597", "260599", "260601", "256055", "239686", "238330", "230385", "228861", "231799", "215962", "215959", "215960", "183821", "212415", "211464", "183819", "197320", "168971", "160632", "150257", "136176", "120739", "122624", "114680", "109435", "107235", "104642"]

Ravelry.configure do |config|
  config.access_key = ENV['RAV_ACCESS']
  config.secret_key = ENV['RAV_SECRET']
  config.personal_key = ENV['RAV_PERSONAL']
end

patterns = []

puts "Begin requesting pattern URLs..."

pattern_urls.each do |url|
  puts "Requesting #{url}"
  pattern = Ravelry::Pattern.new
  pattern.permalink_get(url)
  pattern.build
  patterns << pattern
end

puts ""
puts "Begin requesting pattern IDs..."

pattern_ids.each do |id|
  puts "Requesting #{id}"
  pattern = Ravelry::Pattern.new(id)
  pattern.get
  pattern.build
  patterns << pattern
end

puts "Done fetching!"

template = "<div class='columns four'>NEWLINE<a href='URL'><img src='IMAGE_URL'></a>NEWLINE</div>NEWLINE"
template_blob = []

patterns.each_with_index do |pattern, index|
  index += 1
  permalink = pattern.permalink.split('/').last
  temp = template.sub('URL', "/#{permalink}")
  temp = temp.sub('IMAGE_URL', pattern.photos.first.small_url)
  temp += 'NEWROW' if index % 3 == 0
  template_blob << temp
end

File.open("test.html", "w") { |file| file.write(template_blob.join('')) }

