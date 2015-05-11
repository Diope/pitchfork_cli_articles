require "nokogiri"
require "open-uri"

class Pitchfork

	attr_accessor :doc, :list

	def initialize
		# Create a i.variable that opens pitchfork
		@doc = Nokogiri::HTML(open("http://pitchfork.com/thepitch/"))
		# list will go through doc's (the site's) css looking for certain divs
		# that help direct it to the correct article/article headers
		@list = doc.css("div#page div.post h2 a")
	end

	def the_pitch
		# Thanks to a few folks at Stackoverflow who showed me each_with_index
		# create a numbered list that corresponds to each article
		@list.each_with_index {|article, i| puts "#{i+1}. #{article.text.strip}"}
	end

	def open_story(index)
		# convert index to an integer and index is less or eqal to list length then set the variable link
		# to list index with the href attirbute from headlines, this opens the link
		if index.to_i > 0 && index.to_i <= list.length
			link = list[index.to_i-1].attribute("href").value
			system "open #{link}"
		end
	end

	def call
		# Self explanatory really
		puts "Today on The Pitch via Pitchfork: "
		the_pitch
		puts "\nWhich story would you like to read?"
		i = gets.strip
		open_story(i)
	end
end

Pitchfork.new.call