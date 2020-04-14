# 学习c++ primer 5th edition

[Primer c++ 第5版.pdf](..\..\pdf\c_cpp\Primer c++ 第5版.pdf) 

 [codes](..\..\C_C++_Code\新建文件夹\) 



## ch2

### 2.1 类型转换

* bool <- 其他 , 0为false，其他值为true
* bool-> 其他，false 0，true 1
* float -> int，保留整数
* int -> float，小数部分为0
* 无符号数超过取值，取模
* 带符号数超过取值，编译器行为不确定

warn: 初始化不是赋值，初始化是创建时赋予一个初始值；赋值是把当前对象的值擦去再用一个新值代替

### 2.2 变量

* 列表初始化：如果存在丢数据，会报警告

### 2.3 复合类型

* char* const q & const char* p (顶层const)

```
Person p1("Fred", 200);
const Person* p = &p1;//对象const
person const* p = &p1;//对象const
const *Person p = &p1;//指针const
```

* 识别技巧，从右往左读，p先和左边的符号结合，即*p or const p
  * *p指对象，对象const
  * const p 指指针，指针const

* constexpr和常量表达式
* 初始化空指针，`int *p1=nullptr`区别于`int *p1=NULL`

### 2.5 类的别名

* typedef
* decltype(fun())
  * 返回变量的类型
  * decltype((i))返回的为引用，双层括号必返回引用
* auto
  * 会忽略const，如需要const，应显示的定义`const auto`