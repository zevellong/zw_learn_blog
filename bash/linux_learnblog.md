# linux学习记录





# pacman 学习

## 1. 参数基本含义

| 参数        |      |
| ----------- | ---- |
| -R   (删除) |      |
| -Q  (查询)  |      |
| -S   (安装) |      |



```bash
pacman -S [filename]
pacman -Sy #更新软件库
pacman -Syy #强制
pacman -Su [filename] #更新一个软件
pacman -Syu #更新软件源并更新软件
pacman -Syyu #强制
pacman -Ss [filename] #查询一个软件
pacman -Sc #清除缓存软件包
pacman -R [filename] #删除
pacman -Rs [filename] #删除软件并删除依赖
pacman -Rns [filename] #并删除全局配置文件 检验使用
pacman -Q #查询本地软件
pacman -Q | wc -l #统计多少软件包
pacman -Qe #自己安装的软件包
pacman -Qeq #不显示版本号
pacman -Qdt #查询孤儿依赖软件
sudo pacman  -R $(pacman -Qdtq)
pacman -U #安装本地软件
pacman -Sw #只下载不安装 

pacman 配置文件 /etc/pacman.conf
Color #打开彩色
[archlinuxcn]#软件源
Server= 
```

* pacman手动安装一个例子

~~~bash
git clone https://aur.archlinux.org/ranger-git.git
makepkg
sudo pacman -U ranger-git
~~~

* pacman Key
```shell
#先拷贝一下
sudo rm -R  /etc/pacman.d/gnupg/      # 删除gnupg目录及其文件
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate archlinuxcn    # 启用了archlinux中文软件库的还要执行这个

```
## xxd

## 2020年 03月 07日 星期六 13:24:05 CST** 

| 参数           | 描述                              |
| -------------- | --------------------------------- |
| -a             | 自动跳过空行，默认关闭            |
| -b             | 二进制代替16进制                  |
| -c cols        | 按cols byte每行显示,默认16        |
| -g bytes       | 按bytes字节隔开                   |
| -l num         | 显示num字节停止                   |
| -s [+][-] seek | 偏移seek字节                      |
| -u             | 使用大写字符显示输出信息,默认小写 |

## fdisk 

### 格式化U盘

```bash
sudo fdisk /dev/sdb #删除卷，新建卷
~d
~n
~p
sudo mkfs.ntfs /dev/sdb1 #格式化文件系统
#or
sudo mkfs.ext4 /dev/sdb1 #格式化文件系统
sudo chown your_uname /run/media/your_uname/dev_name #设置权限
e2label /dev/sdb1 "rename dev" #重命名卷名

```

### tar 压缩和解压
* 单个文件压缩打包 tar czvf my.tar file1
* 多个文件压缩打包 tar czvf my.tar file1 file2,...
* 单个目录压缩打包 tar czvf my.tar dir1
* 多个目录压缩打包 tar czvf my.tar dir1 dir2
* 解包至当前目录：tar xzvf my.tar

