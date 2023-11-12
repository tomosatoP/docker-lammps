# docker (rootless mode)

## インストール
いつまで `--skip-iptables` が必要なんだろう？
~~~sh
# 関連パッケージのインストール
toko@host:~$ sudo apt update && sudo apt install uidmap
# docker (root mode) 停止
toko@host:~$ sudo systemctl disable --now docker.service docker.socket
# 手動インストール
toko@host:~$ sudo apt install docker-ce-rootless-extras
toko@host:~$ dockerd-rootless-setuptool.sh check
toko@host:~$ dockerd-rootless-setuptool.sh install --skip-iptables
~~~
~~~sh
toko@host:~$ nano .config/systemd/user/docker.service
~~~
~~~diff
- ExecStart=/usr/bin/dockerd-rootless.sh  --iptables=false
+ ExecStart=/usr/bin/dockerd-rootless.sh
~~~
## DNS設定
> いつまで`コレ`必要なの？
~~~sh
toko@host:~$ sudo cp /etc/resolv.conf /etc/resolv.conf.old
toko@host:~$ sudo nano /etc/wsl.conf
~~~
~~~diff
+ [network]
+ generateResolvConf = false
~~~
~~~sh
toko@host:~$ sudo nano /etc/resolv.conf
~~~
~~~diff
+ nameserver 8.8.8.8
~~~
## 自動起動設定
~~~sh
toko@host:~$ systemctl --user daemon-reload
toko@host:~$ systemctl --user enable docker
toko@host:~$ systemctl --user restart docker
~~~
## 確認
~~~sh
toko@host:~$ docker run --rm hello-world
~~~
---
[top](README.md) [前](wsl-ubuntu.md) [次](nvidia-container-toolkit.md)