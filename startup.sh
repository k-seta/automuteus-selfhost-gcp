#! /bin/sh

mkdir -p /home
cd /home

git clone https://github.com/denverquane/automuteus.git
cd automuteus

export EXTERNAL_IP=$(curl -H "Metadata-Flavor: Google" 'http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip')
export DISCORD_BOT_TOKEN=$(curl -H "Metadata-Flavor: Google" 'http://metadata.google.internal/computeMetadata/v1/instance/attributes/discord-bot-token')

cp sample.env .env
sed -i -e 's/AUTOMUTEUS_TAG=/AUTOMUTEUS_TAG=6.15.2/g' .env
sed -i -e 's/GALACTUS_TAG=/GALACTUS_TAG=2.4.1/g' .env
sed -i -e "s/GALACTUS_HOST=/GALACTUS_HOST=http:\/\/${EXTERNAL_IP}/g" .env
sed -i -e 's/GALACTUS_EXTERNAL_PORT=/GALACTUS_EXTERNAL_PORT=80/g' .env
sed -i -e "s/DISCORD_BOT_TOKEN=/DISCORD_BOT_TOKEN=${DISCORD_BOT_TOKEN}/g" .env

docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$PWD:$PWD" \
    -w="$PWD" \
    docker/compose:1.24.0 up
