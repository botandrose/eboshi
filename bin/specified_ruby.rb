require 'rvm'

module SpecifiedRuby
  extend self

  def ensure!
    install unless installed?
    restart unless current?
  end

  private

  def version
    File.read(".ruby-version").chomp
  end

  def gemset
    File.read(".ruby-gemset").chomp
  end

  def installed?
    installed_rubies = `rvm list strings`.split("\n")
    installed_rubies.include?(version)
  end

  def install
    system("rvm install #{version}") or exit 1
  end

  def current?
    RVM.use_from_path!(".")
    RVM.current.environment_name == [version, gemset].join("@")
  rescue RVM::IncompatibleRubyError
    false
  end

  def restart
    exec "rvm-exec #{$0} && rvm-exec $SHELL"
  end
end

