#!/bin/bash
# prompt ask location of osmose project
while [[ ! -d $workspace ]] ; do
    echo -e "\n\n==>  Please enter your local git repository (your workspace eclipse) for osmose :"
    read workspace
done

export HOST_HASH=$(hostname | sha1sum | head -c 6)
echo "HOST_HASH=$HOST_HASH" > ~/.docker/.env

echo 'alias docker="MSYS_NO_PATHCONV=1 winpty docker"' >> ~/.bash_profile
echo 'alias docker-compose="MSYS_NO_PATHCONV=1 winpty docker-compose"' >> ~/.bash_profile

echo "docker-dev conf"
mkdir ~/.docker &>/dev/null
for i in be cz de es fr hu it nl pl pt ro ru se tr uk at sk
do
	curl -s http://docker.preprod.oxy-net.org/docker-compose-${i}.yml -o ~/.docker/docker-compose-${i}.yml && echo "docker-compose-$i.yml updated" || echo failed to get docker-compose-$i.yml
        sed -i "s|/mnt/country|${workspace}/osmose/application/country|g"  ~/.docker/docker-compose-${i}.yml
done

