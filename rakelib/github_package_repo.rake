require "rubygems/package_task"
require File.expand_path "constants", File.dirname(__FILE__)

GITHUB_GEM_HOST = "https://rubygems.pkg.github.com/NickLaMuro"

namespace :github do
  jeans_gemspec = JEANS_GEMSPEC.dup
  jeans_gemspec.metadata["allowed_push_host"] = GITHUB_GEM_HOST

  Gem::PackageTask.new(jeans_gemspec).define

  desc "Release the package on github"
  task :release => ["release:tag", "release:push"]

  namespace :release do
    task :tag do
      version = jeans_gemspec.version

      run "git", "tag", "-m" "Version #{version}", "v#{version}"
      run "git", "push"
      run "git", "push", "--tags"
    end

    task :push => ["github:package"] do
      gem_filename      = File.basename JEANS_GEMSPEC.cache_file
      relative_pkg_path = File.join "..", "..", "pkg", gem_filename
      package_location  = File.expand_path relative_pkg_path, __FILE__

      run "gem", "push",   package_location,
                 "--key",  "github",
                 "--host", GITHUB_GEM_HOST
    end
  end
end
