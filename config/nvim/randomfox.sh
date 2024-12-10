curl -sS https://api.fox.pics/v1/get-random-foxes | jq -r '.[0]' | \
    xargs -n 1 -I {} sh -c 'curl -s -o /tmp/nvim-fox-wallpaper.png {}; chafa /tmp/nvim-fox-wallpaper.png' --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1
