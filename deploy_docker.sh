echo "Deploying docker containers..."
ruby sshwrapper.rb "cd $1; docker-compose up -d"
