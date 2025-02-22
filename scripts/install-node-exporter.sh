#!/usr/bin/env bash
currentUser=fil
workspace=/root/workspace

cd $workspace
wget -c https://cs-cn-filecoin.oss-cn-beijing.aliyuncs.com/node-exporter/node_exporter-0.18.1.linux-amd64.tar.gz
tar xfvz node_exporter-0.18.1.linux-amd64.tar.gz

sudo mv node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/
sudo chmod a+x /usr/local/bin/node_exporter
rm -rf $workspace/node_exporter-0.18.1.linux-amd64*

mkdir -p /root/prometheus/run

sudo systemctl enable node-exporter
sudo systemctl start node-exporter
