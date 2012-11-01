$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require 'bundler/capistrano'

# Indien u geen RVM gebruikt op uw system kunt u het onderstaande bestand
# downloaden op: https://github.com/wayneeseguin/rvm/blob/master/lib/rvm/capistrano.rb
# Plaats dit in uw applicatie en pas de onderstaande require regel aan.
require 'rvm/capistrano'

# De naam van uw applicatie
set :application, "customer:First"
set :host, "mushu.bluerail.nl"
set :user, "cfirstcrm"

# Versiebeheer instellingen
set :scm, :git
default_run_options[:pty] = true
set :scm_passphrase, "pietje10"
ssh_options[:forward_agent] = true
set :branch, "master"
set :repository, "git@bitbucket.org:jarkelen/customer-first.git"

# De te gebruiken RVM versie, default is 1.8.7. Indien u een Thin installatie
# met Ruby 1.9.2 heeft dan kunt u '1.9.2' als versie opgeven.
set :rvm_ruby_string, 'default'

# De onderstaande instellingen zijn specifiek voor de Bluerail servers, u
# hoeft hier zelf geen wijzigingen in aan te brengen.
set :deploy_to, "~/rails"
set :rvm_type, :system
set :rvm_bin_path, '/usr/local/rvm/bin'
set :use_sudo, false
set :keep_releases, 3

role :web, host
role :app, host
role :db,  host, :primary => true

# Taak voor het herstarten van de Passenger applicatie en symlinken van de database.yml
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  after "deploy:update_code", :link_production_db

end

#after "deploy", "deploy:migrate"

desc "Link database.yml from shared path"
task :link_production_db do
  run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
end


