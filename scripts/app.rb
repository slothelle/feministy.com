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

template = "<div class='row'><div class='columns four'><a href='URL'><img src='IMAGE'></a></div><div class='columns eight'><h2><a href='URL'>PATTERN_NAME</a></h2><p><strong>projects: </strong>PROJECT_COUNT</p><p><strong>favorites: </strong>FAVORITE_COUNT</p><p><strong>queues: </strong>QUEUED_COUNT</p></div></div>NEWLINE"

pattern_template = '<!DOCTYPE html><!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]--><!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]--><!--[if IE 8]><html class="no-js lt-ie9"> <![endif]--><!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]--><head><base href="/"><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"><title>feministy.com - uniquely simple knitwear design by liz abinante</title><meta name="description" content=""><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="css/main.css"><!-- Place favicon.ico and apple-touch-icon.png in the root directory --></head><body ng-app="feministyDotCom"><div id="landing-page" ui-view="landing-page"><!-- pretty landing page stuff! --></div><div id="nav" class="row" ui-view="nav"></div><div class="container">    <div id="header" class="row" ui-view="header"></div>    <div id="content" class="row" ui-view="content"><div id="pattern"><h1 class="centered">PATTERN_NAME</h1>   <div class="row"><div class="columns six centered"><img src="IMAGEFIRST"></div><div class="columns six centered"><img src="IMAGESECOND"></div></div>       ***STUFF*****     </div></div></div><!--[if lt IE 7]>    <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]--><script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script><script>window.jQuery || document.write(\'<script src="js/jquery.min.js"><\/script>\')</script><script src="js/index.js"></script></body></html>'

template_blob = []
shawls_blob = []
cowls_blob = []
socks_blob = []
hats_blob = []

patterns.sort_by { |pattern| pattern.projects_count }.reverse.each do |pattern|
  permalink = pattern.permalink.split('/').last
  temp = template.gsub('URL', "/#{permalink}")
  temp = temp.sub('IMAGE', pattern.photos.first.small_url)
  temp = temp.sub('PATTERN_NAME', pattern.name.downcase)
  temp = temp.sub('FAVORITE_COUNT', pattern.favorites_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse)
  temp = temp.sub('PROJECT_COUNT', pattern.projects_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse)
  temp = temp.sub('QUEUED_COUNT', pattern.queued_projects_count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse)
  template_blob << temp

  if pattern.categories.map(&:name).include?("Shawl / Wrap") || pattern.categories.map(&:name).include?("Scarf")
    shawls_blob << temp 
  elsif pattern.categories.map(&:name).include?("Mid-calf")
    socks_blob << temp 
  elsif pattern.categories.map(&:name).include?("Cowl")
    cowls_blob << temp 
  elsif pattern.categories.map(&:name).include?("Beanie, Toque")
    hats_blob << temp 
  else
    puts pattern.categories.map(&:name)
  end 
end

File.open("patterns.html", "w") { |file| file.write(template_blob.join('')) }
File.open("shawls.html", "w") { |file| file.write(shawls_blob.join('')) }
File.open("socks.html", "w") { |file| file.write(socks_blob.join('')) }
File.open("cowls.html", "w") { |file| file.write(cowls_blob.join('')) }
File.open("hats.html", "w") { |file| file.write(hats_blob.join('')) }
# File.open("pattern_blob.html", "w") { |file| file.write(pattern_blob) }
