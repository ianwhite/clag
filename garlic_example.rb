# This is for running specs against target versions of rails
#
# To use do
#   - cp garlic_example.rb garlic.rb
#   - rake get_garlic
#   - [optional] edit this file to point the repos at your local clones of
#     rails, rspec, and rspec-rails
#   - rake garlic:all
#
# All of the work and dependencies will be created in the galric dir, and the
# garlic dir can safely be deleted at any point

garlic do
  repo 'rails', :url => 'git://github.com/rails/rails'#, :local => "~/dev/vendor/rails"
  repo 'rspec', :url => 'git://github.com/dchelimsky/rspec'#, :local => "~/dev/vendor/rspec"
  repo 'rspec-rails', :url => 'git://github.com/dchelimsky/rspec-rails'#, :local => "~/dev/vendor/rspec-rails"
  repo 'clag', :path => '.'

  target 'edge'
  target '2.0-stable', :branch => 'origin/2-0-stable'
  target '2.1-stable', :branch => 'origin/2-1-stable'
  target '2.0.3', :tag => 'v2.0.3'
  target '2.1.0', :tag => 'v2.1.0'
  
  all_targets do
    prepare do
      plugin 'clag', :clone => true
      plugin 'rspec'
      plugin('rspec-rails') { sh "script/generate rspec -f" }
    end
  
    run do
      cd("vendor/plugins/clag") { sh "rake spec:rcov:verify" }
    end
  end
end