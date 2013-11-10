puts "External dependency *wkhtmltopdf* not found! Please install." unless `which wkhtmltopdf` and $?.success?
puts "External dependency *imagemagick* not found! Please install." unless `which identify` and $?.success?
