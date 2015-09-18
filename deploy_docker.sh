echo "Deploying docker containers..."

REVISION=$GO_REVISION_LD_KB_QS
REPO_URL=$2
TARGET_DIR=$1

bundle exec ruby sshwrapper.rb "cd $TARGET_DIR"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git clone $REPO_URL ."
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; git reset --hard $REVISION"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose pull"
bundle exec ruby sshwrapper.rb "cd $TARGET_DIR; docker-compose up -d"
