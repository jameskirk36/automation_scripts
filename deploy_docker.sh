echo "Deploying docker containers..."

REVISION=$GO_REVISION_LD_KB_QS
TARGET_DIR=$1

bundle exec ruby sshwrapper.rb "cd $TARGET_DIR" || exit(1)
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose stop" || exit(1)
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git pull" || exit(1)
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git reset --hard $REVISION" || exit(1)
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose pull" || exit(1)
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose up -d" || exit(1)
