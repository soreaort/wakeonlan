#!/bin/bash

PROVISIONING_PATH="/usr/lib/python3/dist-packages/provisioningserver/"

echo "Installing wakeonlan"
apt-get install -y wakeonlan

echo "Copying wakeonlan.py..."
cp -vf wakeonlan.py ${PROVISIONING_PATH}drivers/power/wakeonlan.py

echo "Import WakeOnLANPowerDriver..."
grep -qxF "from provisioningserver.drivers.power.wakeonlan import WakeOnLANPowerDriver" ${PROVISIONING_PATH}drivers/power/registry.py || sed '/from provisioningserver.utils.registry import Registry/i from provisioningserver.drivers.power.wakeonlan import WakeOnLANPowerDriver' -i ${PROVISIONING_PATH}drivers/power/registry.py

echo "Adding WakeOnLANPowerDriver() method..."
grep -qxF "    WakeOnLANPowerDriver()," ${PROVISIONING_PATH}drivers/power/registry.py || sudo sed '/power_drivers = \[/a\    WakeOnLANPowerDriver(),' -i ${PROVISIONING_PATH}drivers/power/registry.py


echo "Restarting rackd and regiond..."
systemctl restart maas-rackd.service maas-regiond.service
