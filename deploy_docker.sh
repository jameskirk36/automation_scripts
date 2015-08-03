echo "Deploying docker containers..."
bundle exec ruby sshwrapper.rb "cd $1; git pull"
bundle exec ruby sshwrapper.rb "cd $1; docker-compose pull"
bundle exec ruby sshwrapper.rb "cd $1; docker-compose up -d"
