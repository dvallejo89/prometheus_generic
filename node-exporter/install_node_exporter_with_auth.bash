#!/bin/bash

## Define la versión de Node Exporter que deseas instalar
NODE_EXPORTER_VERSION="1.7.0"

## Descarga Node Exporter
curl -LO "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

## Descomprime el archivo tar.gz
tar xvfz "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

## Mueve el binario a /usr/local/bin
sudo mv "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter" /usr/local/bin/
#
## Limpia los archivos descargados
rm -rf "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/"
rm "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
#
## Crea un usuario para ejecutar Node Exporter
sudo useradd -rs /bin/false node_exporter
#
## Crea un servicio de systemd
echo '[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/node_exporter.service

## Recarga el daemon de systemd, habilita y arranca el servicio Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter