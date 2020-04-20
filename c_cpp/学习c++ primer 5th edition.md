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

## 4 表达式

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



## 5 语句

* 不能在while ()的条件定义,循环条件中的定义的变量，在循环体中不能直接引用的

```c++
	//[Error] expected initializer before '!=' token
	while (auto iter != str1.end()) 
	{
		*iter = toupper(*iter);
	}
```

* 悬垂else，else总是找在他上方离他最近的if

* switch内部定义变量

```c++
	
	switch(a)
	{
		case 1:
			string file3;//控制流跳过了一个隐式的初始化
			string file_name = "file1";//控制流跳过了一个显式的初始化
			int i;//正确，没有初始化
			break;
		case 2:
			i = 30;
			break; 
	}

	//可以定义在块内
	
	switch(a)
	{
		case 1:
            {
                string str("hello");
            }
	}
```

* case语句不要使用变量

```c++
	unsigned i = 512, j = 1024, k = 4096;
	unsigned bufsize;
	unsigned swt = 512;
	switch (swt){
		case i:
			bufsize = i * sizeof(int);
		case j:
			bufsize = j * sizeof(int);
		case k:
			bufsize = k * sizeof(int);
	}
//[Error] the value of 'i' is not usable in a constant expression
```

* for循环的条件为空语句，这默认为true

## 6 函数

* 函数是一个命名的代码块

* const 形参和实参

```c++
void fcn(const int i)//形参的顶层const会被忽略
void fcn(int i)//error:重复定义
```

* 尽量使用常量引用

```c++
void print(string &sr)
{
	cout << sr << endl;
}

print("hello"); //hello子字符串字面值，应该为const string &
//[Error] invalid initialization of non-const reference of type 
//'std::string& {aka std::basic_string<char>&}' from an rvalue of type //'const char*'
```

* 更加隐讳的错误

```c++
string::size_type print(string &sr,char c)
{
	
}
bool is_sentence(const string& s)
{
	string::size_type ctr = 0;
	return find_char(s, '.') == s.size();
    //s的类型与size_type()定义的类型不匹配
}
```

* 数组三种遍历方法：

  * 标记：C的字符串最后有一个空字符
  * 标准库规范：begin和end，end指向最后一个元素的下一块
  * 显式传递数组大小：`void print(const int a[], size_t size)`
* 数组引用形参

```c++
void print(int (&arr)[10])
{
	for (auto ele : arr)
		cout << ele << " ";
	cout << endl;
}
//切记括号不能少
f(int &arr[10])//一个含有10个int 引用的数组
f(int (&arr)[10]) //数组的引用
    
//传递二维数组
void print(int (*matrix)[10]);
```

* 可变形参 `initializar_list<T> lst;`

```c++
void lst_msg(const string &send_name,initializer_list<string> lst)
{	
    cout << "To " << send_name << ":"<< endl;
	for (auto beg=lst.begin(); beg != lst.end() ; ++beg)
	{
		cout << *beg << " ";
	}
}

lst_msg({"hello", "world"});
```

* 列表初始化返回值

```c++
vector<string> rtn_hello_str()
{
	return {"hello", "world"};
}
```

* 返回函数指针的函数

```c++
int (*func(int i))[10];
//func(int i)表示函数
//(*func(int i)) 表示对函数的结果解引用
//(*func(int i))[10] 表示func返回的是一个大小为10的数组

//使用尾置返回类型 -std=C++11
//更直观
auto fun2(int i) -> int (*)[10]
{
	
}

//使用decltype
int odd[] = {1, 2, 3, 4, 5};
decltype(odd) *fun3(int i)
{
}
//decltype不负责把数组类型转换为指针，要加一个*
```

* 函数重载，函数名相同，参数不相同

```c++
//错误，不能只有返回类型不同
int f1(int i);
bool f1(int i);


Record lookup(Phone);
Record lookup(const Phone);//重复声明了上一行

Record lookup(Phone* );
Record lookup(Phone* const);//重复声明了上一行

Record lookup(Account& );
Record lookup(const Account&);//新函数

Record lookup(Account* );
Record lookup(const Account* );//新函数
```



* 在局部块声明函数会隐藏包含此名的函数，不是一个好的选择
* 内联函数和constexpr函数放在头文件中



* 函数匹配
  * 最佳匹配
  * 无匹配
  * 二义性

```c++
f(int, int);
f(double, double);

//call f
f(40, 3.14);//二义性
//f(int, int)精确匹配, f(double, double)也精确匹配，编译器拒绝

```

* 参数转换等级(上方的等级高)
  *  精确匹配
    * 完全相同
    * 数组类型和函数类型转换为指针类型
    * 顶层const
  * const转换的匹配
  * 类型提升，char -> int
  * 算术类型转换或者指针类型转换
  * 类类型转换

## 7 类

* class 与 struct唯一区别就是默认访问权限
* 友元
  * 一般来说，最好在类的开始或结束处集中声明友元
* 声明和定义的地方都可以说明`inline`，但是最好只在类的外部定义的地方说明`inline`，比较好理解

```c++
struct X{
	friend void f(){};
    x() {f();}//错误
    void g();
    void h();
}
void X::g() { return f();}//错误
void f();
void X::h() { return f();}//正确
```

* 友元的声明影响访问权限，不是普通意义的声明
* 名字查找
  * 普通情况
    * 首先在当前块中
    * 外层作用域
    * 还没有找到，报错
  * 类成员函数
    * 首先找成员声明
    * 直到类全部可见才编译函数体

* 类的初始化顺序，最好与成员声明的顺序保持一致；并且尽量避免用其他的成员初始化其他成员
* 委托构造函数

* 使用默认的构造函数

```c++
Sales_data obj(); //定义了一个函数
Sales_data obj2; //一个对象，调用默认构造器
```

* 隐式的类型转换
  * 只允许一次类类型转换

```c++
Sales_data& Sales_data::combine (const Sales_data&);

Sales_data item;
//"9-999-99999" -> string -> Sales_data
item.combine("9-999-99999");//错误，只能转换一次
item.combine(string("9-999-99999"));//显示转为string，隐式转sales
item.combine(Sales_data("9-999-99999"));//隐式转为string，显式转sales
```

* 在构造器加入 `explicit` 可以拟制隐式转换

```
Sales_data item1(null_book);//正确直接初始化
Sales_data item2 = null_book;//错误，explicit禁止拷贝构造
```

* 标准库中的explicit

```
//接受一个单参数的const char* string
//vector单参数，圆括号
```

* static
  * 静态成员函数不能使用this，也不能在后面加const
  * 可以用类名访问静态成员，也可以用对象名
  * 可以在类的内部和外部定义static函数。在外部定义时，不要重复定义static，这个关键字只出现在类的内部