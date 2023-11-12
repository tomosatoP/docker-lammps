# NVIDIA Container Toolkit

## インストール 
~~~sh
toko@host:~$ nvidia-smi --query-gpu=name --format=csv,noheader
# > NVIDIA GeForce RTX 3060

toko@host:~$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
toko@host:~$ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-docker-keyring.gpg
toko@host:~$ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-docker-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

toko@host:~$ sudo apt update
toko@host:~$ sudo apt install -y nvidia-docker2
~~~

## 設定変更
~~~sh
# 非cgroups ユーザーを許可 
toko@host:~$ sudo nano /etc/nvidia-container-runtime/config.toml
~~~
~~~diff
- #no-cgroups = false
+ no-cgroups = true
~~~

## 確認
~~~sh_
toko@host:~$ docker run --rm hello-world
toko@host:~$ docker run --rm -it --gpus all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi
~~~
---
[top](README.md) [前](docker_rootless-mode.md)