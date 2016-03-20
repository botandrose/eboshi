require 'delorean'

# Make sure we fix the time up after each scenario
After do
  Delorean.back_to_the_present
end
