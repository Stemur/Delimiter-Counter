#!/usr/bin/env ruby

require 'optparse'

options = {
	:countonly => false,
	:filename => nil
}

optparse = OptionParser.new do |opt|
	opt.banner = 'Usage: delimcount.rb [options] -i <filename>'

	opt.on_tail('-c','Display delimiter counts only.') do 
		options[:countonly] = true 
	end

	opt.on_tail('-h', 'Displays this screen.') do
		puts optparse
		exit
	end

	opt.on('-i <filename>', '--input FILE', "Filename to parse.") do 
		|inputfile| options[:filename] = inputfile
	end
end

if ARGV.empty?
	puts optparse
  	exit(-1)
end

begin
	optparse.parse!
	rescue OptionParser::ParseError
		puts optparse
	  	exit(-1)
end

options

i=0
# Check the file exists 
if options[:filename] == nil
	puts optparse
	exit(-1)
else
	$inputfile = options[:filename]	
end

puts "Filename : %s" % [options[:filename]]
if options[:countonly] == true
	puts "Displaying delimiter count for each line only."
end
File.open($inputfile,"r").each_line do |line|
	i += 1
	delcount = line.count ","
	if options[:countonly] == true
		puts "CO : Line : %-5i Delimiters : %-4i" % [i, delcount]
	else
		puts "Line : %-5i Delimiters : %-4i Data : %s" % [i, delcount, line]
	end
end
