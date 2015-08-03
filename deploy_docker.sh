echo "Deploying docker containers..."
revision=$GO_REVISION_LD_MIMIR
command="
  cd $1;\
  git reset --hard;\
  git pull;\
  sed -i \"s_nice/mimir_&:$revision\" docker-compose.yml;\
  docker-compose pull;\
  docker-compose up -d;\
"
bundle exec ruby sshwrapper.rb "$command"
