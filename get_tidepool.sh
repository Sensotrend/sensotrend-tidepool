#!/usr/bin/env bash

echo "Cloning tidepool-tools..."
cd /home/vagrant
mkdir -p tidepool
cd tidepool
if [ -d "tools" ]; then
    echo "Skipping, because there is already a directory by that name."
else
    git clone https://github.com/tidepool-org/tools.git > tidepool-tools.log
fi

echo "Doing initial checkout..."
cd tools
sh ./get_current_tidepool_repos.sh > tidepool-checkout.log

# Add some convenient aliases for tidepool
echo "alias tidepool-runservers='cd /home/vagrant/tidepool/ && . tools/runservers'" > /etc/profile.d/tidepool.sh
echo "alias tidepool-update='cd /home/vagrant/tidepool/tools && sh ./update_current_tidepool_repos.sh'" >> /etc/profile.d/tidepool.sh
