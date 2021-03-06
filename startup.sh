#! /bin/sh

mkdir -p /home

# AutoMuteUs
cd /home
git clone https://github.com/denverquane/automuteus.git

export EXTERNAL_IP=$(curl -H "Metadata-Flavor: Google" 'http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip')
export DISCORD_BOT_TOKEN=$(curl -H "Metadata-Flavor: Google" 'http://metadata.google.internal/computeMetadata/v1/instance/attributes/discord-bot-token')

cp /home/automuteus/sample.env /home/automuteus/.env
sed -i -e 's/AUTOMUTEUS_TAG=/AUTOMUTEUS_TAG=6.11.0/g' /home/automuteus/.env
sed -i -e 's/GALACTUS_TAG=/GALACTUS_TAG=2.4.1/g' /home/automuteus/.env
sed -i -e "s/GALACTUS_HOST=/GALACTUS_HOST=http:\/\/${EXTERNAL_IP}/g" /home/automuteus/.env
sed -i -e 's/GALACTUS_EXTERNAL_PORT=/GALACTUS_EXTERNAL_PORT=80/g' /home/automuteus/.env
sed -i -e "s/DISCORD_BOT_TOKEN=/DISCORD_BOT_TOKEN=${DISCORD_BOT_TOKEN}/g" /home/automuteus/.env

docker run -d \
    --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/automuteus:/home/automuteus \
    -w=/home/automuteus \
    docker/compose:1.24.0 up

# factorio
cd /home
git clone https://github.com/k-seta/factorio.git

export MODS_URL=$(curl -H "Metadata-Flavor: Google" 'http://metadata.google.internal/computeMetadata/v1/instance/attributes/factorio-mods-url')

cd /home/factorio
docker build . -t local/factorio-headless

docker run -d \
    --rm \
    --name factorio \
    -p 34197:34197 \
    local/factorio-headless
