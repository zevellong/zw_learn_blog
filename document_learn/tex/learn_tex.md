用tex写论文

[参考](E:\learn\pdf\tex\lnotes2.pdf)

* 文章主体

```latex
%英文
\documentclass{article}
%中文
\documentclass{ctexart}
```

* 正文

```latex
\begin{document}
	内容
\end{document}
```

* 设置标题作者日期

```latex
\title {hello, world}
\author{zw}
\date{\today}
\maketitle
```

* 摘要

```latex
\begin{abstract}
	Hello, wolrd 5 lines.
\end{abstract}
```

* 目录

```latex
\setcounter{tocdepth}{2}
\tableofcontents
```

* 目录的层次结构

| 命令           | 描述 |
| -------------- | ---- |
| \part{...}     | -1   |
| \charpter{}    | 0    |
| \section       | 1    |
| \subsection    | 2    |
| \subsubsection | 3    |
| \paragraph     | 4    |
| \subparagraph  | 5    |

* 强调

```latex
\usepackage[normalem]{ulem}

\underline{	Hello, world!}\\%下划线
\emph{Hello, world!}\\ %斜体
\uline{Hello, world!}\\ %下划线		
\uwave{Hello, world!}\\ %波浪线	
\sout{Hello, world!}\\ %删除线
```

* 换行 换页 

```
\underline{	Hello, world!}\\ % \\换行
\underline{	Hello, world!}\newline % \newline换行

\newpage %换页
```

* 设置页面

```latex
%后面再补
\setlength{变量名} %设置变量的值 
\addtolength{变量名} %增加变量的值 
\newlength{变量名} %定义新变量
```

* 段落对齐

```latex
% 缺省两端对齐
\raggedright %左
\centering %居中
\raggedleft %右

%或者
\begin{flushleft}
居左\\段落 
\end{flushleft}

\begin{flushright}
居右\\段落 
\end{flushright}

\begin{center} 
居中\\段落 
\end{center}
```

* 缩进 段间距 行间距

```latex
% 缺省时第一个段落不缩进首行

%用indentfirst让第一个段落也首行缩进
\usepackage{indentfirst}

 %段落首行缩进的距离可以用 \parindent 变量 来控制
\setlength{\parindent}{2em} 

%段落之间的距离可以用\parskip变量来控制
\addtolength{\parskip}{3pt}

%行间距是段落中相邻两行基线之间的距离，LATEX缺省使用单倍行距
\linespread{1.3} %一倍半行距 
\linespread{1.6} %双倍行距

%\linespread命令不仅会改变正文行距，同时也把目录、脚注、图表 标题等的行距给改了。如果只想改正文行距，可以使用setspace宏包
\usepackage{setspace} 
\singlespacing %单倍行距
\onehalfspacing %一倍半行距 
\doublespacing  %双倍行距
\setstretch{1.25} %任意行距
%行距
\begin{doublespacing} 
double\\spacing 
\end{doublespacing}

\begin{spacing}{1.25}
any\\spacing 
\end{spacing}
```

* 代码

```latex
\verb|command| 行间命令

\begin{verbatim} 
printf("Hello, world!");
\end{verbatim}

%与上面相比能标出空格
\begin{verbatim*}
printf("Hello, world!"); 
\end{verbatim*}
```

* 列表

```latex
%无序列表
\begin{itemize}
    \item C++ 
    \item Java 
    \item HTML
\end{itemize}

%有序列表
\begin{enumerate}
    \item C++ 
    \item Java 
    \item HTML
\end{enumerate}

%描述列表
\begin{description}
    \item[C++] 编程语言 
    \item[Java] 编程语言 
    \item[HTML] 标记语言 
\end{description}

%其他列表

%显示为a b c ...
\usepackage{paralist}
\begin{enumerate} 
    \item C++ 
    \item Java 
    \item HTML
\end{enumerate}
```



```shell
bmeps -c xx.pdf xx.eps #eps格式
pdf2svg xx.pdf xx.svg #linux svg格式

```

