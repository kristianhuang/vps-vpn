# vps-v2ray

## 事前准备

cn2 节点 VPS 一台。

## 自行安装

### 服务端安装 v2ray

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

### 开启服务器 BBR（可选）

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

## 一键脚本安装

1. 下载一键安装脚本：`$ sudo curl -O https://raw.githubusercontent.com/kristianhuang/vps-v2ray/refs/heads/main/v2ray_install.sh`;
2. 运行一键安装脚本：`$ sudo path/v2ray_install.sh`;
3. （可选）下载 BBR 脚本：`$ sudo curl -O https://raw.githubusercontent.com/kristianhuang/vps-v2ray/refs/heads/main/bbr_start.sh`;
4. （可选）运行 BBR 脚本：`$ sudo ptah/bbr_start.sh`;
5. 下载一键删除脚本：`$ curl -O https://raw.githubusercontent.com/kristianhuang/vps-v2ray/refs/heads/main/v2ray_remove.sh`;
6. （可选）当需要删除 v2ray 时，关闭 v2ray 后，运行 `$ sudo path/v2ray_remove.sh`;

