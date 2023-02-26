/bin/bash

echo "removing config"
rm config.txt

echo "creating config"
touch config.txt

echo "inserting config data"
echo "token = $token" >> config.txt
echo "owner = $owner" >> config.txt
echo "prefix = \"$prefix\"" >> config.txt

java -Dnogui=true -jar musicBot.jar