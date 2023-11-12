# cgroup v2 (保留)
docker (rootless mode) を制限無しに使うには、cgroup v2 が推奨なんだけど
~~~sh
PS C:\home> notepad $Env:UserProfile\.wslconfig
~~~
~~~diff
[wsl2]
+ # only cgroup v2
+ kernelCommandLine = cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1
~~~
---
[top](README.md) [次](wsl-ubuntu.md)