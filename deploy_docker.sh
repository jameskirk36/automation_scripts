echo "Deploying docker containers..."

REVISION=$GO_PIPELINE_LABEL
TARGET_DIR=$1

bundle exec ruby sshwrapper.rb "cd $TARGET_DIR" || exit $?
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose stop" || exit $?
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git pull" || exit $?
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git reset --hard $REVISION" || exit $?
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose pull" || exit $?
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose up -d" || exit $?
