#! /bin/sh

mkdir -p /home
cd /home

# AutoMuteUs
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
sleep 30; mkdir -p /home/factorio
chown -R 845:845 /home/factorio

docker run -d \
    -p 34197:34197/udp \
    -p 27015:27015/tcp \
    -v /home/factorio:/factorio \
    --name factorio \
    --restart=always \
    factoriotools/factorio
