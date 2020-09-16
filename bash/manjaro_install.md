# manjaro gnome install

- pacman

```shell
sudo pacman-mirrors -i -c China -m rank
sudo pacman -Syy
#在 /etc/pacman.conf 文件末尾添加以下两行

[archlinuxcn]
#SigLevel = TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
[antergos]
#SigLevel = TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/antergos/$repo/$arch

#安装 archlinuxcn-keyring 包导入GPG key
sudo pacman -Sy archlinuxcn-keyring
sudo pacman -S yaourt
```

- speaker

```shell
#adding next code to /etc/modprobe.d/alsa-base.conf
options snd-hda-intel dmic_detect=0 

#reboot
```

- 

```shell
sudo pacman -S vscode vim gcc typora bochs make cmake figlet screenfetch gdb chromium netease-cloud-music vlc inkscape
```

* keyboard 



* vim

```c++
vim plugin

```

* 输入法

```
sudo pacman -S ibus ibus-rime
#adding in ~/.xprofile or ~/.bashrc
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -d -x

# seting find input medtod
```



* anaconda

```
#download anaconda64.sh
chmod a+x

echo 'export PATH="~/anaconda3/bin:$PATH"'>>~/.bashrc  
source ~/.bashrc    
conda config --set auto_activate_base false 

	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud//pytorch/
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
	conda config --set show_channel_urls yes
```

* latex

```shell
# download ios
sudo pacman -S perl-tk
sudo mount -o loop texlive.iso /mnt
cd /mnt
sudo ./install-tl -gui 
sudo pacman -S texstudio
sudo umount
```

* vscode

```shell
#插件 c code runner
#setting->zoom level:1  text font:18
```

