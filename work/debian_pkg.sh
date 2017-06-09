#!/bin/bash
# TODO list
# Need to rebuild Passenger  module for new ruby version
# update .ruby-version
# Check gems location
# Add dependence: ruby2.1,ruby2.1-dev,ruby-switch
RUBY=ruby2.1.2
RUBY_VERSION=2.1.2
USER=deploy

DEST_DIR=/var/www/lithium/current
SHARED=/var/www/krypton/shared
GEM_HOME=/opt/gems
GEM_PATH=$GEM_HOME/ruby/$RUBY_VERSION
FILE_VERSION=$DEST_DIR/.ruby-version

echo "Changing owner/group of /var/www/lithium to ubuntu ..."
mkdir -p $GEM_PATH
chown -R $USER:$USER $DEST_DIR
chown -R $USER:$USER $GEM_PATH


echo "Updating ruby version ..."
echo $RUBY_VERSION > $FILE_VERSION

echo "Creating gemrc ..."
cat > /etc/gemrc <<EOF
# Created by debian package
gem: --no-rdoc --no-ri
gemhome: $GEM_HOME
gempath:
 - $GEM_PATH
EOF

echo "Linking to settings in the shared folder"
for var in development staging production; do
  su -c "rm -f $DEST_DIR/config/settings/${var}.yml;ln -s $SHARED/config/settings/${var}.yml  $DEST_DIR/config/settings/" $USER
done

#echo "Selecting ${RUBY}....."
#ruby-switch --set RUBY
#ruby -v

echo "Installing gems...."
su -c "cd $DEST_DIR;source ~/.rvm/scripts/rvm;export GEM_HOME=$GEM_HOME;export GEM_PATH=$GEM_PATH;bundle install --local --path $GEM_HOME" $USER
echo "Done!"
exit 0
