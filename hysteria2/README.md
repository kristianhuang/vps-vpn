# hysteria2
<!-- TOC -->
* [hysteria2](#hysteria2)
  * [服务端](#服务端)
    * [流程说明](#流程说明)
    * [服务端配置文件](#服务端配置文件)
    * [删除](#删除)
<!-- TOC -->

## 服务端

### 流程说明

1. 安装 `$ bash <(curl -fsSL https://get.hy2.sh/)`；
2. 填写配置文件；
3. 启动。

### 服务端配置文件

文件路径 `/etc/hysteria/config.yaml`。


无域名配置：

如果没有域名，需要先生成自签名证书 `$ openssl req -x509 -nodes -newkey ec:<(openssl ecparam -name prime256v1) -keyout /etc/hysteria/server.key -out /etc/hysteria/server.crt -subj "/CN=bing.com" -days 36500 && sudo chown hysteria /etc/hysteria/server.key && sudo chown hysteria /etc/hysteria/server.crt`

```
listen: :443 # 若 443 无法连接，尝试使用其他端口
 
tls:
 cert: /etc/hysteria/server.crt
 key: /etc/hysteria/server.key
 
auth:
  type: password
  password: 88888888   # 用户密码，此处自行设置
 
masquerade:
  type: proxy
  proxy:
    url: https://baidu.com # 伪装网站, 不建议再使用微软旗下的相关域名
    rewriteHost: true
```

有域名配置：

```
listen: :443 # 若 443 无法连接，尝试使用其他端口
 
acme:
  domains:
    - yourdomain.com        # 域名
  email: your@email.com   # 邮箱，格式正确即可
 
auth:
  type: password
  password: 88888888   # 用户密码，此处自行设置
 
masquerade:
  type: proxy
  proxy:
    url: https://baidu.com # 伪装网站, 不建议再使用微软旗下的相关域名
    rewriteHost: true
```

### 删除

`$ bash <(curl -fsSL https://get.hy2.sh/) --remove`