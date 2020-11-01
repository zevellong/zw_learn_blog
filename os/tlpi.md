#  Linux Programing Interface

## file IO

```bash
	# 测试文件写入剪贴板
	cat xx.cpp.new | xclip -selection cclipboard
	# 
	alias cattest=" cat test.c | xclip -selection cclipboard" 
```



```
#include <stdio.h>
#include <tlpi_hdr.h>
#include <sys/stat.h>
#include <fcntl.h>

#ifndef BUF_SIZE_
#define BUF_SIZE_ 1024
#endif

// Source file copy to dest file
int main(int argc, char *argv[])
{
	int inputFd, outPutFd, openFlags;
	mode_t filePerms;
	ssize_t numRead;
	char buf[BUF_SIZE_];
	
	if (argc != 3 || (strcmp(argv[1], "--help")) == 0 )
		usageErr("%s old-file new-file\n", argv[0]);
	inputFd = open(argv[1], O_RDONLY);
	if (inputFd <= 0)
		usageErr("%s open error\n", argv[1]);
	openFlags = O_CREAT | O_WRONLY | O_TRUNC;
	filePerms = S_IRUSR | S_IWUSR | S_IRGRP
			| S_IWGRP | S_IROTH | S_IWOTH;
	outPutFd = open(argv[2], openFlags, filePerms);
	if (outPutFd <= 0)
		usageErr("%s open error\n", argv[2]);
	
	while ((numRead = read(inputFd, buf, BUF_SIZE_)) > 0)
	{
		if (write(outPutFd, buf, numRead) != numRead)
			fatal("coundn't write buffer");
	}
	if (numRead == -1)
		errExit("read");
	if (close(inputFd) == -1)
		errExit("close input");
	if (close(outPutFd) == -1)
		errExit("close outPut");

	exit(0);
}
```



* open(filename, flags, ... mode)
  * 打开一个文件

| flags       | describe                               |
| ----------- | -------------------------------------- |
| O_RDONLY    | 只读                                   |
| O_WRONLY    | 写                                     |
| O_RDWR      | 读写                                   |
| O_CREAT     | 不存在则创建                           |
| O_DIRECTORY | 不是目录返回-1（errno=ENOTDIR）        |
| O_NOATIME   | 不修改访问时间，需要权限               |
| O_NOFOLLOW  | 不进行软链接解引用                     |
| O_SYNC      | 同步IO打开文件                         |
| O_TRUNC     | 已存在且为普通文件，清空文件，需写权限 |
| O_NONBLOCK  | 非阻塞方式打开                         |
|             |                                        |
|             |                                        |
|             |                                        |
|             |                                        |

* 返回值， 成功返回文件描述符， 失败返回-1
* 错误

| error   |                                                              |
| ------- | ------------------------------------------------------------ |
| EACCES  | flags参数不允许进程调用，可能是权限问题，文件不存在且无法创建 |
| EISDIR  | 打开文件属于目录                                             |
| EMFILE  | 进程打开的文件描述符达上限                                   |
| ENOENT  | 不存在且为指定creat，或者目录不存在，或者符号链接指向的不存在 |
| EROFS   | 只读文件系统，企图写方式打开                                 |
| ETXTBSY | 指定的文件为可执行文件，不允许修改正在执行的文件             |
|         |                                                              |

* read
* write
  * write可以在文件末尾的任意处写数据，导致文件空洞
  * 文件空洞在编程角度存在字节，读取文件空洞返回0到缓冲区，但不占磁盘空间

```c
#include <stdio.h>
#include <tlpi_hdr.h>
#include <sys/stat.h>
#include <fcntl.h>

#ifndef BUF_SIZE_
#define BUF_SIZE_ 1024
#endif

int main(int argc, char *argv[])
{
	off_t oft = 10000;
	int sourceFile = open(argv[1], O_WRONLY | O_CREAT);
	printf("set seek %d Bytes\n", oft);
	if (lseek(sourceFile, oft, SEEK_CUR) == -1)
		errExit("lseek");
	if (write(sourceFile, argv[2], strlen(argv[2])) < 0)
		errExit("write");
	if (close(sourceFile) == -1)
		errExit("close");

	exit(EXIT_SUCCESS);
}


//运行 ./test xx.cpp.new abc
//ls -al 逻辑字节为10003
//du xx.cpp.new 实际字节为 8
```

* lseek

| seek     |        |
| -------- | ------ |
| seek_set | 开头   |
| seek_cur | 当前   |
| seek_end | 文件尾 |

### 原子操作和竞争

```c
int fd = open(argv[1], O_WRONLY);
if (fd != -1){
    printf("File exits\n");
    close(fd);
}else{
    if (errno != ENOENT)
        errExit("open"); //unexpected error
    else{
        fd = open(argv[1], O_CREAT | O_WRONLY, );
    }
}
```

* 上述进程试图独占的使用文件
* 但是可能存在打开文件判断不存在后， 另一进程时间开始，创建了此文件
* 使用 `flags = O_EXCL | O_CREAT`,原子操作，可以独占的创建文件
* 两个进程使用lseek在文件尾写数据，也可能引起竞争，导致一个进程的数据被覆盖，使用`flags=O_APPEND`原子操作，总在文件末尾添加

### 文件控制符操作 fcntl

```c
// 添加文件控制符O_APPEND的例子
int flags;
flags = fcntl(fd, F_GETFL);
flags |= O_APPEND;
fcntl(fd, F_SETFL, flags);
```

* 常用场景
  * 文件不是由该进程创建的，如标准输入，在进程运行前就打开了
  * pipe(), socket()

### 文件描述符和打开文件的关系

* 进程的文件描述符表
* 系统的打开文件表（所以进程共享）
  * 文件偏移
  * 状态标志（flags）
  * 文件的访问模式
  * 信号IO设置
  * inode对象
* 文件的inode表（共享）
  * 文件类型
  * 文件的锁
  * 文件的属性，文件大小，时间等信息

### 复制文件描述符

`int dup(int oldfd)`

`bint dup2(int oldfd, int newfd)`

```c
int newfd = dup(1); // newfd复制为标准输出
int xx = dup2(1, 2); //相当于先关闭标准错误，然后将2复制为标准输出
int newfd = fcntl(oldfd, F_DUPFD, startfd); // 返回一个大于等于startfd的文件描述符
```

* dup2调用如果newfd已经打开，则关闭它，此时忽略关闭错误；因此最好在调用dup2时，显示的关闭（调用close）



```c
pread(fd, buf, size, offset);
pwrite(fd, buf, size, offset);
//和read write相同， 但不会改变文件的偏移量， 偏移量由offset决定
```

### /dev/fd 目录

* 每个进程，内核都虚拟的一个文件目录

### 临时文件

fd = mkstemp(char * tem)

### 非局部跳转

```c
#include <stdio.h>
#include <tlpi_hdr.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <setjmp.h> 
#ifndef BUF_SIZE_
#define BUF_SIZE_ 1024
#endif

static jmp_buf jbuf;
static void f2()
{
	longjmp(jbuf, 2);
}
static void f1(int argc)
{
	if (argc == 1)
		longjmp(jbuf, 1);
	f2();
}
extern char** environ;
int main(int argc, char *argv[])
{
	switch(setjmp(jbuf)){
		case 0:
			printf("init and call f1() \n");
			f1(argc);
			break;
		case 1: 
			printf("jump bacj from f1()\n");
			break;
		case 2:
			printf("jumo back from f2()\n");
	}
	return 0;
}

```

* 从不同的函数返回
* 与goto不同， goto只能存在与相同的函数间
* setjmp() 一般只用于， if， switch， while的控制表达式
  * 以及 == < 等逻辑关系符
* 滥用longjmp
  * 调用 f1(), 使用setjmp，返回
  * 然后调用f2(), 使用全局的buf调用 longjmp
  * 行为是未定义的，因为f1调用后栈帧可能消失
* 优化可能导致 longjmp出错
  * 调用longjmp的函数尽量使用volatile

```c
#include <stdio.h>
#include <tlpi_hdr.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <setjmp.h> 
#ifndef BUF_SIZE_
#define BUF_SIZE_ 1024
#endif

extern char** environ;

static jmp_buf jbuf;
void doJmp(int nvar, int rvar, int vvar)
{
	
	printf("After longjmp: navr=%d  rvar=%d, vvar=%d \n",
					nvar, rvar, vvar);
	longjmp(jbuf, 1);
}

int main(int argc, char *argv[])
{
	int nvar = 111;
	register int rvar = 222;
	volatile int vvar = 333;

	if (setjmp(jbuf) == 0)
	{
		nvar = 777;
		rvar = 888;
		vvar = 999;
		doJmp(nvar, rvar, vvar);

	}else
	{
		printf("After longjmp: navr=%d  rvar=%d, vvar=%d \n",
					nvar, rvar, vvar);
	}
}


/*
#  运行结果	
test.c  -o test                                         
~/.../vscode_workspace/csapp >>> ./test                                                      
After longjmp: navr=777  rvar=888, vvar=999 
After longjmp: navr=777  rvar=222, vvar=999 
~/.../vscode_workspace/csapp >>> gcc test.c  -o test -O                                      
~/.../vscode_workspace/csapp >>> ./test                                                      
After longjmp: navr=777  rvar=888, vvar=999 
After longjmp: navr=111  rvar=222, vvar=999 
~/.../vscode_workspace/csapp >>> cattest      


*/
```



* alloca(size)
  * 在栈上分配内存
  * 不能在函数调用中使用 alloca，比如 `fun(a, alloca(10), c);`
  * alloca分配的数组会随栈的释放而释放，相比malloc速度更快
  * 配合longjmp而不会导致内存泄漏

### 用户和组

**/etc/passwd**

用户名 x表示加密的密码 用户ID 组ID 注释 主目录 shell

```bashh
zw:x:1000:1000:zw:/home/zw:/bin/zsh
```

**/etc/group**

组名 密码 组ID 用户列表

```bash
zw:x:1000:
```

### 进程凭证

* 实际用户ID 组ID
* 有效 
* set-user-id set-group-id
* 保存的set＊id

* 系统和进程信息
  * /proc/pid/* 文件
  * 记录了进程的信息，进程开始时创建，结束时删除

| file    |                                          |
| ------- | ---------------------------------------- |
| cmdline | 命令行参数                               |
| cwd     | 指向当前目录的符号链接                   |
| environ | 环境列表                                 |
| exe     | 正在执行的文件的符号链接                 |
| fd      | 文件目录，包含了进程打开的文件的符号链接 |
| maps    | 内存映射                                 |
| mem     | 进程虚拟内存                             |
| mounts  | 进程安装点                               |
| root    | 指向根目录的符号链接                     |
| status  | 各种信息 进程ID 凭证 内存 信号           |
| task    | 线程                                     |
|         |                                          |

uname

* 主机系统标识信息

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <tlpi_hdr.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <setjmp.h> 
#include <stdlib.h>
#include <sys/utsname.h>


#ifndef BUF_SIZE_
#define BUF_SIZE_ 1024
#endif



int main(int argc, char *argv[])
{
	struct utsname um;
	if (uname(&um) == -1)
		errExit("uname");

	printf("Node name: %s\n", um.nodename);
	printf("sys name: %s\n", um.sysname);
	printf("release name: %s\n", um.release);
	printf("version name: %s\n", um.version);
	printf("Machine name: %s\n", um.machine);
#ifdef _GNU_SOURCE
	printf("Domain name: %s\n", um.domainname);
#endif
}

```



## process


## signal

