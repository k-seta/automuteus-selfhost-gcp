#! /bin/sh

mkdir -p /home/lavoce
cd /home/lavoce

git clone https://github.com/denverquane/automuteus.git
cd automuteus

EXTERNAL_IP=$(curl -H "Metadata-Flavor: Google" 'http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip')

cp sample.env .env
sed -i -e 's/AUTOMUTEUS_TAG=/AUTOMUTEUS_TAG=6.11.0/g' .env
sed -i -e 's/GALACTUS_TAG=/GALACTUS_TAG=2.4.1/g' .env
sed -i -e "s/GALACTUS_HOST=/GALACTUS_HOST=${EXTERNAL_IP}/g" .env
sed -i -e 's/GALACTUS_EXTERNAL_PORT=/GALACTUS_EXTERNAL_PORT=80/g' .env
