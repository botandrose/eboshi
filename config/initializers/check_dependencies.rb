if RUBY_PLATFORM !~ /darwin/i
  raise "External dependency *wkhtmltopdf* not found! Please install." unless `which wkhtmltopdf` and $?.success?
  raise "External dependency *imagemagick* not found! Please install." unless `which identify` and $?.success?
end
