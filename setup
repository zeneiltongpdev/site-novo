#!/bin/bash

function check_installation {
  hash $1 2>/dev/null || { echo >&2 "$1 is not available; aborting."; exit 1; }
}

function check_ruby {
  check_installation ruby
  ruby -v | grep "ruby 2" >/dev/null || {
    echo >&2 "! you need ruby version >= 2; aborting."; exit 1;
  }
  echo "✓ ruby is ok."
}

function check_mysql {
  check_installation mysql
  mysql --version | grep "Distrib 5" >/dev/null || {
    echo >&2 "You need mysql version >= 5; aborting."; exit 1;
  }
  echo "✓ mysql is ok."
}

function restore_database {
  echo "restoring the database..."
  curl "https://dl.dropboxusercontent.com/u/83384696/mst2.sql.gz" > mst2.sql.gz
  gzip -d mst2.sql.gz
  mysql -u root -e "drop database if exists mst2; create database mst2; SET GLOBAL max_allowed_packet=1073741824;"
  mysql -u root mst2 < mst2.sql
  rm mst2.sql
  echo "✓ database is restored."
}

function install_gems {
  echo "installing gems"
  gem install bundler >/dev/null && bundle install && echo "✓ gems are installed."
}

echo "setting up movimento-sem-terra/site-novo..."
check_mysql
check_ruby
restore_database
install_gems
echo "setup is complete!"

