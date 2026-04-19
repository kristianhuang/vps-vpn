#!/bin/sh

# install and start v2ray
sudo bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
sudo bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)


# set v2ray config
sudo echo '{
  "inbounds": [
    {
      "port": 11223,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "81498305-0be0-4923-a270-df4e490a086b",
            "alterId": 0,
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
' > /usr/local/etc/v2ray/config.json