# Lammps: WSL-Ubuntu GPU, docker compose
Lammps を手軽に使いたかったので、サービスを作りました

* WSL + Ubuntu-22.04
* Intel Core i5-10400F (Comet Lake 6 cores, 12 threads)
* NVIDIA GeForce RTX 3060 (Ampere 3584 cores, VRAM 12GB)

## 環境構築
* [cgroup v2 (保留)](guide/cgroupv2.md)
* [Ubuntu-22.04 on WSL 環境構築](guide/wsl-ubuntu.md)
* [docker (rootless mode) 手動インストール](guide/docker_rootless-mode.md)
* [NVIDIA Container Toolkit インストール](guide/nvidia-container-toolkit.md)

## Lammps
### インストール
~~~sh
toko@host:~/docker-lammps$ git clone git clone -b release --depth 1 https://github.com/lammps/lammps.git lammps
toko@host:~/docker-lammps$ mkdir data
toko@host:~/docker-lammps$ cp -r lammps/examples data/exmples 
# サービス用のコンテナを作成
toko@host:~/docker-lammps$ docker compose build
~~~
### サービス lammps を一度限りのコマンドとして実行
~~~sh
toko@host:~/docker-lammps$ docker compose run lammps
# Dockerfile の CMD の内容を置き換え
toko@host:~/docker-lammps$ docker compose run lammps bash build_check.sh
~~~
### サービスを停止
~~~sh
toko@host:~/docker-lammps$ docker compose stop
toko@host:~/docker-lammps$ docker compose down
~~~
### 更新
~~~sh
toko@host:~/docker-lammps/lammps$ git pull
toko@host:~/docker-lammps$ docker compose build
~~~
---
## [参考] GPU アクセレーションの使い方
~~~sh
# no acceleration
lmp -in $INPUT_FILE

# GPU + OpenMPI + OpenMP
mpirun --allow-run-as-root -np 6 lmp -sf hybrid gpu omp -pk omp 2 -in $INPUT_FILE

# GPU + OpenMPI + OpenMP(not package) + OPT
mpirun --allow-run-as-root -x OMP_NUM_THREADS=1 -np 6 lmp -sf hybrid gpu opt -in $INPUT_FILE

# GPU + OpenMPI + OpenMP(not package)
mpirun --allow-run-as-root -x OMP_NUM_THREADS=1 -np 6 lmp -sf gpu -in $INPUT_FILE
~~~
---
