echo "Deploying docker containers..."

REVISION=$GO_REVISION_LD_KB_QS
TARGET_DIR=$1

bundle exec ruby sshwrapper.rb "cd $TARGET_DIR"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose stop"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git pull"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git reset --hard $REVISION"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose pull"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose up -d"
