require 'ravelry'

pattern_urls = ["goodbye-california", "very-pdx-hat", "crenel-hat", "misdirected-cowl", "in-winter", "forest-park-cowl", "winter-sea-shawl-2"]

pattern_ids = ["419443", "382813", "379890", "333038", "350319", "209052", "210188", "303053", "311429", "313002", "309557", "311149", "303654", "305054", "205477", "300500", "296623", "284798", "265288", "260602", "260597", "260599", "260601", "256055", "239686", "238330", "230385", "228861", "231799", "215962", "215959", "215960", "183821", "212415", "211464", "183819", "197320", "168971", "160632", "150257", "136176", "120739", "122624", "114680", "109435", "107235", "104642"]

Ravelry.configure do |config|
  config.access_key = ENV['RAV_ACCESS']
  config.secret_key = ENV['RAV_SECRET']
  config.personal_key = ENV['RAV_PERSONAL']
end

patterns = []

puts "Begin requesting pattern IDs..."

pattern_ids.each do |id|
  puts "Requesting #{id}"
  pattern = Ravelry::Pattern.new(id)
  pattern.get
  patterns << pattern
end

puts ""
puts "Begin requesting pattern URLs..."

pattern_urls.each do |url|
  puts "Requesting #{url}"
  pattern = Ravelry::Pattern.new
  pattern.permalink_get(url)
  patterns << pattern
end

puts "Done fetching!"

json_blob = patterns.map(&:json).join(', ')
File.open("patterns.json", "w") { |file| file.write(json_blob) }

