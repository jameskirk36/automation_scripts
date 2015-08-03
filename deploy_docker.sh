echo "Deploying docker containers..."
bundle exec ruby sshwrapper.rb "cd $1; docker-compose up -d"
