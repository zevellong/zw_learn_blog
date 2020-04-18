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



## 3 string & vector

### 3.1 string

string 初始化

```c++
    string s1;
    string s2(s1);
    string s3("value");
    string s4(50, 'c');
```

string 的操作

| 操作             |                      |
| ---------------- | -------------------- |
| os << s, is >> s | 输入，输出           |
| getline(is, s)   | 读取一行到s          |
| s.empty()        | 判断空               |
| s.size()         | size                 |
| s[n]             | 索引到s的n个字符     |
| s1+s2            | 字符串连接           |
| s1=s2            | 赋值                 |
| s1==s2           | 判断相等，大小写敏感 |
| s1!=s2           | 不相等               |
| < , <=, >, >=    | 判断大于，小于       |

###  vector

```c++
#include <iostream>
#include <vector>

//初始化
	vector<string> v1;
    vector<string> v2(v1);
    vector<string> v3(10, "hello");
    vector<string> v4(10);
    vector<string> v5 {"hello", "world", "cpp"};
//添加元素
	v1.push_back(3);
	

```

* 在for each循环中，不要使用`push_back()`
* vector的操作

| vector              | 操作                |
| ------------------- | ------------------- |
| v.empty()           |                     |
| v.size()            |                     |
| v.push_back         |                     |
| v[n]                | 返回第n个元素的引用 |
| v1 = v2             |                     |
| v1 = {a, b, c, ...} | 列表初始化          |
| v1 == v2            |                     |
| v1 != v2            |                     |
| <, >, <=, >=        |                     |

* `vector<int>::size_type` 而不是 `vector::size_type` ，
* 不能用下标的形式添加元素

### 3.3 迭代器

* 迭代器运算符

| 迭代器    | 作用                         |
| --------- | ---------------------------- |
| *iter     | 返回迭代器iter指向元素的引用 |
| iter->num | 获取num                      |
| _         |                              |
| --iter    |                              |
| ==        |                              |
| !=        |                              |

* 迭代器的失效，一些有副作用的操作，使得迭代器失效
* 在C++中迭代器使用!=，而不是<,>,因为大多数类库都实现了!=
* 迭代器的类型

```c++
vector<int>::iterator it;
string::iterator it2;
//const 只能读，不能写
vector<int>::const_iterator it3;
string::const_iterator it4;

```

* begin，end，会识别是不是const
* (*it).empty() 而不是 *it.empty(),或者it->empty()
* iterator::difference_type，带符号整数

## 表达式

| 结合律        | 功能               | 用法            |
| ------------- | ------------------ | --------------- |
| 左 ::         | 全局作用域         | ::name          |
| 左 ::         | 类作用域           | class::name     |
| 左 ::         | 命名空间作用域     | namespace::name |
|               |                    |                 |
| 左 .          | 成员               |                 |
| 左 ->         | 成员               |                 |
| 左 []         | 下标               |                 |
| 左 ()         | 函数调用           |                 |
| 左 ()         | 类型构造           | type(expr_list) |
|               |                    |                 |
| ++            |                    |                 |
| --            |                    |                 |
| typeid        |                    |                 |
| typeid        |                    |                 |
| explicit cast |                    |                 |
| 逻辑运算      | != < >             |                 |
| ~             | 位取反             |                 |
| -             | 一元负号           |                 |
| +             | 一元正号           |                 |
| *             | 解引用             |                 |
| &             | 取地址             |                 |
| ()            | 类型转换           |                 |
| sizeof        |                    |                 |
| new           |                    |                 |
| delete        |                    |                 |
| noexcept      |                    |                 |
|               |                    |                 |
| ->*           | 指向成员选择的指针 |                 |
| .*            | 指向成员选择的指针 |                 |
|               |                    |                 |
| + -           |                    |                 |
|               |                    |                 |
| << >>         | 位移位             |                 |
|               |                    |                 |
|               |                    |                 |

* 太多了，见cpp primer， 147



