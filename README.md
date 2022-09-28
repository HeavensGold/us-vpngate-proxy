# us-vpngate-proxy

This is a US version of ja-vpngate-proxy(forked, non official). Original source code:  https://github.com/tantan-tanuki/ja-vpngate-proxy)

[VPNGate](http://www.vpngate.net/api/iphone/)から日本のVPNサーバだけを抽出してランダムに接続します  
ブラウザのプロキシ設定でlocalhost:8119を設定することで使用できます

> また、日本サーバであってもpublic-vpn-から始まるVPN(219.100.37.0/24)は同じ場所からのアクセスになってしまうため除外しました

# 起動

```bash
docker run --rm -it \
--cap-add=NET_ADMIN --device=/dev/net/tun \
--dns=1.1.1.1 --dns=8.8.8.8 --dns=9.9.9.9 \
-p 8119:8119 \
heavens007/us-vpngate-proxy
```

# 起動確認

proxy指定有り無しでcurlしてグローバルIPが異なっていれば成功です

```bash
$ curl inet-ip.info
$ curl inet-ip.info -x http://localhost:8119
```
