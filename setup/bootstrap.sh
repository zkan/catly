#!/bin/bash

sudo apt-get update

# dependencies for ruby
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

su vagrant <<'EOF'
git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bash_profile
git clone https://github.com/sstephenson/rbenv-gem-rehash.git /home/vagrant/.rbenv/plugins/rbenv-gem-rehash
EOF
echo 'Installed rbenv'

su vagrant <<'EOF'
source /home/vagrant/.bash_profile
rbenv install 2.2.3
rbenv global 2.2.3
EOF
echo 'Installed Ruby'

su vagrant <<'EOF'
source /home/vagrant/.bash_profile
echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc
gem install bundler
EOF
echo 'Installed Bundler'

# nodejs
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
echo 'Installed Node.js'

# rails
su vagrant <<'EOF'
source /home/vagrant/.bash_profile
gem install rails -v 4.2.4
rbenv rehash
EOF
echo 'Installed Rails'

# postgresql
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
su vagrant <<'EOF'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
EOF
sudo apt-get update
suDo apt-get install -y postgresql-common
sudo apt-get install -y postgresql-9.3 libpq-dev
echo 'Installed PostgreSQL'
