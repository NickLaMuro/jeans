require "rubygems/package_task"
require File.expand_path "constants", File.dirname(__FILE__)

namespace :rubygems do
  Gem::PackageTask.new(JEANS_GEMSPEC).define

  def gem_run *args
    require "rubygems/gem_runner"
    require "rubygems/exceptions"

    Gem::GemRunner.new.run args
  end

  desc "Install the build of the gem locally"
  task :install => [:package] do
    require "rubygems"

    begin
      gem "jeans", JEANS_GEMSPEC.version
      puts "#{JEANS_GEMSPEC.full_name} already installed!"
    rescue LoadError
      # Installing with the `--no-wrappers` so we can get the speed up from the
      # `--disable-gems` in the bin script.
      #
      # Doesn't work on Windows, since it symlinks, but it will fall back to
      # the wrapper if it doesn't work.
      gem_run "install", "--no-wrappers", "pkg/#{JEANS_GEMSPEC.full_name}.gem"
    end
  end

  desc "Uninstall local package"
  task :uninstall do
    gem_run "uninstall", "-x", "jeans"
  end

  desc "Repackage, Uninstall and Install"
  task :reinstall => [:repackage, :uninstall, :install]
end
