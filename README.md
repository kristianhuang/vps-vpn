# vps-vpn

## 事前准备

cn2 节点 VPS 一台。

## 服务端安装并配置 v2ray

1. 安装

`$ bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)`

`$ bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)`

2. 填写配置文件

3. 开启 v2ray，`$ sudo systemctl start v2ray`。

删除 v2ray: `$ bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove`

### vmess 服务端配置

```
// /usr/local/etc/v2ray/config.json
{
  "inbounds": [
    {
      "port": 11223, // 对外端口
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "81498305-0be0-4923-a270-df4e490a086b", // 自定义 id，客户端配置与此处一致
            "alterId": 64, // shadowrocket 连接此处填 0
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
```

## 开启服务器 BBR

`$ sudo vim /etc/sysctl.conf `

```
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
```

使配置生效

`$ sysctl -p`

检查是否开启成功

`$ sudo sysctl net.ipv4.tcp_available_congestion_control`

输出 bbr 则开启成功

- 注：内核大于4.9.
