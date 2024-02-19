## Define la versión de Node Exporter que deseas instalar
NODE_EXPORTER_VERSION="1.7.0"

## Descarga Node Exporter para aarch64
curl -LO "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64.tar.gz"

## Extrae el archivo tar
tar xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64.tar.gz

## Mueve el binario de Node Exporter a /usr/local/bin
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64/node_exporter /usr/local/bin/

## Limpieza de archivos no necesarios
rm node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64.tar.gz
rm -r node_exporter-${NODE_EXPORTER_VERSION}.linux-arm64

## (Opcional) Crea un archivo de servicio de systemd para gestionar Node Exporter como un servicio
echo -e '[Unit]\nDescription=Node Exporter\nAfter=network.target\n\n[Service]\nUser=root\nExecStart=/usr/local/bin/node_exporter\n\n[Install]\nWantedBy=default.target' | sudo tee /etc/systemd/system/node_exporter.service

## Recarga systemd para que lea el nuevo archivo de servicio
sudo systemctl daemon-reload

## Habilita el servicio de Node Exporter para que se inicie en el arranque
sudo systemctl enable node_exporter

## Inicia el servicio de Node Exporter
sudo systemctl start node_exporter
