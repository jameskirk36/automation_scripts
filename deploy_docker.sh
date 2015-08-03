echo "Deploying docker containers..."
bundle ruby sshwrapper.rb "cd $1; docker-compose up -d"
