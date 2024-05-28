if docker login 2>/dev/null | grep -q "Login Succeeded"
then
    echo "already logged into Docker HUb"
else
    docker login
fi

read -p "TAG_NAME:" tag_name

docker build -t "tabisch/discordmusicbot:$tag_name" -t "tabisch/discordmusicbot:latest" .

docker push "tabisch/discordmusicbot:latest"

docker push "tabisch/discordmusicbot:$tag_name"