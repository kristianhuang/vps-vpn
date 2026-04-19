# v2ray
<!-- TOC -->
* [v2ray](#v2ray)
  * [服务端](#服务端)
    * [流程说明](#流程说明)
    * [开启 TLS （推荐）](#开启-tls-推荐)
    * [服务端配置文件](#服务端配置文件)
    * [开启服务器 BBR（可选）](#开启服务器-bbr可选)
    * [一键脚本安装](#一键脚本安装)
    * [相关使用命令](#相关使用命令)
    * [删除](#删除)
    * [删除 acme.sh](#删除-acmesh)
<!-- TOC -->

## 服务端

### 流程说明

1. 安装；

`$ bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)`

`$ bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)`

2. 填写配置文件；

3. 启动 v2ray。

### 开启 TLS （推荐）

1. 购买域名，解析至服务器 IP；
2. 下载 TLS 证书认证脚本 `$ curl  https://get.acme.sh | sh`；
3. 刷新环境 `$ source ~/.bashrc`; 
4. 生成证书，yourdomain.com 替换为自己的域名 `sudo ~/.acme.sh/acme.sh --issue -d yourdomain.com --standalone -k ec-256`；
5. 将生成的证书、密钥安装至 v2ray 配置文件同路径，`$ sudo ~/.acme.sh/acme.sh --installcert -d yourdomain.com --fullchainpath /usr/local/etc/v2ray/v2ray.crt --keypath  /usr/local/etc/v2ray/v2ray.crt --ecc`
6. 修改配置文件;
7. 重启 v2ray。

注：
- 如果启动后，无法正常连接，可能是 `/usr/local/etc/v2ray/v2ray.key` 或 `/usr/local/etc/v2ray/v2ray.key` 的权限不足；

### 服务端配置文件

默认配置文件路径 `/usr/local/etc/v2ray/config.json`
下方配置文件，实际使用时，删除所有 `//` 备注。

不开启 TLS 配置：

```
{
  "inbounds": [
    {
      "port": 443, // 对外端口
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

开启 TLS 配置：

```
{
  "inbounds": [
    {
      "port": 443, // 建议使用 443 端口
      "protocol": "vmess",    
      "settings": {
        "clients": [
          {
            "id": "81498305-0be0-4923-a270-df4e490a086b", // 自定义 id，客户端配置与此处一致
            "alterId": 64, // shadowrocket 连接此处填 0
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/usr/local/etc/v2ray/v2ray.crt", // 证书文件
              "keyFile": "/usr/local/etc/v2ray/v2ray.key" // 密钥文件
            }
          ]
        }
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

### 一键脚本安装

1. 下载一键安装脚本：`$ sudo curl -O https://raw.githubusercontent.com/kristianhuang/vps-vpn/refs/heads/main/v2ray/v2ray_install.sh`;
2. 运行一键安装脚本：`$ sudo path/v2ray_install.sh`;
3. （可选）下载 BBR 脚本：`$ sudo curl -O https://raw.githubusercontent.com/kristianhuang/vps-vpn/refs/heads/main/v2ray/bbr_start.sh`;
4. （可选）运行 BBR 脚本：`$ sudo ptah/bbr_start.sh`;
5. 下载一键删除脚本：`$ curl -O https://raw.githubusercontent.com/kristianhuang/vps-vpn/refs/heads/main/v2ray/v2ray_remove.sh`;
6. （可选）当需要删除 v2ray 时，关闭 v2ray 后，运行 `$ sudo path/v2ray_remove.sh`;

注：
- 一件安装脚本，使用不开启 TLS 的配置文件，如果需要开启，参考上方文档。

### 相关使用命令

- 开启 v2ray `$ systemctl start v2ray`;
- 重启 v2ray `$ systemctl restart v2ray`;
- 停止 v2ray `systemctl stop v2ray`;
- 检查运行状态 `systemctl status v2ray`.

### 删除
删除前，需要先关闭 v2ray。

`$ bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove`

### 删除 acme.sh

1. `sudo ~/.acme.sh/acme.sh --uninstall`;
2. `sudo rm -rf ~/.acme.sh/`。