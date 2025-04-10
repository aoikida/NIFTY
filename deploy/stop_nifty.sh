#!/bin/bash

# get NIFTY_HOME
. ../configuration

# If your ssh need more options, you can set them in the $sshOptions variable (you can set identify file, port, ...)
sshOptions=" -i /home/ubuntu/NIFTY/rabia.pem "

# For each of the nodes in deployment, run partitiner.
while IFS= read -r nodeIP
do
	if [ -z $nodeIP ]; then
		continue;
	fi
	echo "Stopping Nifty on node $nodeIP"
	# Could need to either run the script as sudo or add sudo here to be able to deploy rules. (or have OVS not require sudo)
	ssh -n $sshOptions ubuntu@$nodeIP sudo killall nifty
	ssh -n $sshOptions ubuntu@$nodeIP sudo ovs-ofctl del-flows br0 cookie=1/-1
    ssh -n $sshOptions ubuntu@$nodeIP sudo ovs-ofctl del-flows br0 cookie=2/-1
    ssh -n $sshOptions ubuntu@$nodeIP sudo ovs-ofctl del-flows br0 cookie=3/-1
    ssh -n $sshOptions ubuntu@$nodeIP sudo ovs-ofctl del-flows br0 cookie=4/-1
    ssh -n $sshOptions ubuntu@$nodeIP sudo ovs-ofctl del-flows br0 cookie=5/-1
    ssh -n $sshOptions ubuntu@$nodeIP sudo ovs-ofctl del-flows br0 cookie=6/-1 
done < ./nodes.conf