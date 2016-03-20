puts "External dependency *wkhtmltopdf* not found! Please install." unless `which wkhtmltopdf` && $?.success?
puts "External dependency *imagemagick* not found! Please install." unless `which identify` && $?.success?
