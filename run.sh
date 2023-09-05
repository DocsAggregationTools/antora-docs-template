#!/bin/bash

basedir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

init() {
  echo "安装 Antora 依赖"
  cd ${basedir}
  rm -rf node_modules
  rm -rf .cache
  rm -rf public
  npm cache clear --force
  npm install
  echo "安装 Antora 依赖完毕\n"
}

site_generator() {
  echo "\n生成 Antora 站点"
  cd ${basedir}
  rm -rf public
  npx antora --clean --fetch --stacktrace antora-playbook.yml
  echo "生成 Antora 站点完毕\n"
}

start_server() {
  echo "\n启动预览"
  cd ${basedir}
  npm start
}

case $1 in
  init)
    init
    ;;
  gen)
    site_generator
    ;;
  preview)
    site_generator
    start_server
    ;;
  *)
    echo "sh run.sh init     # npm intall 依赖"
    echo "sh run.sh gen      # 生成站点"
    echo "sh run.sh preview  # 启动一个服务预览站点"
    ;;
esac
