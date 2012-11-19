if RUBY_PLATFORM !~ /darwin/i
  raise "External dependency *wkhtmltopdf* not found! Please install." unless `which wkhtmltopdf` and $?.success?
end
