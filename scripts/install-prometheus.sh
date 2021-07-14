#!/usr/bin/env bash
currentUser=root
sudo mkdir -p /mnt/md0/prometheus
sudo tee /mnt/md0/prometheus/prometheus.yaml <<-'EOF'
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'Lotus'
    scrape_interval: 5s
    static_configs:
      - targets:
        - 192.168.1.221:9100
EOF

sudo docker pull prom/prometheus:latest
sudo docker run -d \
  -p 9090:9090 \
  -v /mnt/md0/prometheus:/prometheus \
  -v /mnt/md0/prometheus/database:/prometheus/database \
  --name prometheus \
  --network host \
  prom/prometheus:latest \
  --config.file=/prometheus/prometheus.yaml \
  --storage.tsdb.path=/prometheus/database \
  --storage.tsdb.retention.time=90d \
  --web.enable-admin-api
