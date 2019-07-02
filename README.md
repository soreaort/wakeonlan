# wakeonlan - It works for MAAS version: 2.5.2

Add WoL power type to MAAS 2.5.2, *JUST FOR TESTING PURPOSES*. 

NOTE: Option A and B does exactly the same, option B was only created for verbosity.

## A) Run it thru script
sudo sh run.sh

## B) Run it manually 
sudo apt-get install -y wakeonlan
git clone git@github.com:soreaort/wakeonlan.git
cd wakeonlan/
cp wakeonlan.py /usr/lib/python3/dist-packages/provisioningserver/drivers/power/wakeonlan.py

### Edit:
/usr/lib/python3/dist-packages/provisioningserver/drivers/power/registry.py
*and add below line before* "_from provisioningserver.utils.registry import Registry_" 
from provisioningserver.drivers.power.wakeonlan import WakeOnLANPowerDriver
*within* "_power_drivers_" block
WakeOnLANPowerDriver(), 

### Restart rackd and regiond
systemctl restart maas-rackd.service maas-regiond.service
