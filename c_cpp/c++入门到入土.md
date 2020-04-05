# c++入门到入土

### 2020-4-4

## 头文件

* 类的声明放在头文件
* 在cpp文件放定义

## 定义和声明

* 一个cpp文件是一个编译单元
* 定义放在头文件
  * extern
  * 函数原型
  * 类声明

```c++
//防止多次被include
#ifndef HEADER_FLAG
#define HEADER_FLAG
//some declaration
#endif
```

* 一个头文件放一个声明
* 源代码文件使用.cpp

## 抽象

* 在某种程度不去思考内部细节，在某一个层面上考虑
* 一个对象分成几个部分看待
* 符合大多数人的思路

## 成员变量(Fields)



## 构造和析构

* 构造器：和类的名字一样，无返回类型，对象创建自动被调用
* 析构函数：对象删除的时候调用
* 初始化：构造函数调用，定义的时候才会调用
* default构造器：没有参数

## new & delete

```c++
new int;
new int[10];
delete p;
delete[] p;
```

* new会分配空间，调用构造函数，返回分配的地址
* 用new [],使用delete []
* delete调用析构，再回收空间
* 使用new[],调用delete，只会析构第一个，空间都会收回
* inch table：记录地址和内存大小
* 如果delete与table内容找不到，运行出错
* tips：
  * 不要用delete收回不是new的空间
  * 不要delete两次同一块空间
  * 可以delete null
  * new []和dlete[]一起调用，new和delete

### 2020-4-2 15:59

## 拷贝构造

```c++
T::T(const T&);
```

* 成员级别的拷贝
* 默认的拷贝构造，会将成员一个一个拷贝，指针也会拷贝， 而不是分配内存
* Constructions vs. assignment
  * 初始化只会做一次
  * 构造一次也会被析构一次
  * 一个对象construction一次，assignment多次
* 如果是私有的，别人不能拷贝
* 

## template

* 重用代码，类型成为参数

* 两种template，function template，class template

```c++
template <class T>
void swap(T& x, T& y){
	T temp = x;
	x = y;
	y = temp;
}	

int i = 3;
int j = 1;
swap(i,j);
```

```c++
//Interactions
swap(int, int) //yes
swap(float, float)//yes
swap(int, float)//no
swap<int> (a, b);
```

```c++
//vector members 类函数每一个函数都是模板
template <class T>
Vector<T>::Vector(int size) : m_size(size){
	m_elements = new T[m_size];
}
template <class T>
T& Vector<T>::operator[] (int index){
    if (index < m_size && indx > 0){
        return m_elements[index];
    }else {
        ...
    }
}

```

* template 可以多个参数

```c++
template< class Key, class Value>
template< class Key, int bounds = 100 >
```

* template 和 inheritance
```c++
// non-template classes
template< class A>
class Derived : public Base{ ... }

//
template< class A>
class Derived : public List<A> { ... }

class Derived : public Employee<A> { ... }
```



## exception

* 由于外界的条件，程序可能不正常运行

### Example

```txt
// read a file
open the file
determine its size
allocate that much memory
read the file into memory
close the file
```

```c++
try{
    open the file
	determine its size
	allocate that much memory
	read the file into memory
	close the file
}catch (fileOpenFailed) {
    doSomething
}catch (sizeDeterminationFailed) {
    doSomething
}catch (memoryAlloctionFailed) {
    doSomething
}catch (readFailed) {
    doSomething
}catch (fileColseFailed) {
    doSomething
}

throw <something>
```



## stream

* in c, printf, scanf
* Advantages of steams
  * safety
  * Extensible
  * More obkect-oriented
* Disadvantage
  * more verbose
  * Often slower

* what is a stream
  * 一维单方向

|                   | Input         | Output        | Headr       |
| ----------------- | ------------- | ------------- | ----------- |
| Generic           | istream       | ostream       | <iostream>  |
| File              | ifstream      | ofstream      | <fstream>   |
| C string <legacy> | istrstream    | ostrstream    | <strstream> |
| C string          | istringstream | ostringstream | <sstream>   |

* stream operations
  * Extractors (>>)
  * inserters (<<)
  * Manipulators: change the stream state
  * function
* kinds of streams
  * text streams : ASCLL text
  * Binart streams
* Predefined stream
  * cin
  * cout
  * cerr
  * clog

```c++
	istream& operator>> (istream& is, T& obj){
        // 特殊的格式读流
        return is;
    }
```

* chaining  `cin >> a >> b >> c`
* `istream& get(char& ch)`
* `get(char *buf, int limit, char delim = '\n')`
  * limit限制读入长度
  * 追加null在字符串后
  * 不消耗delim符号

* `getline(char* buf, int limit, char delim ='\n')`
  * 追加null
  * 消耗delim
* `ignore(int limit=1, int delim = EOF)`
  * 跳过limit个字符
  * 遇到delim结束
* `int gcount()`
  * 读入多少字节
* `int putback(char)`
  * 放回去一个字节
* `char peek()`
  * 偷窥
* `flush`
  * `cout << "something" << flush;`

* xx

| manipulator        | effect       | type |
| ------------------ | ------------ | ---- |
| dec, hex,oct       | 10,16,8进制  | I/O  |
| endl               | 换行         | O    |
| flush              | 刷新流       | O    |
| setw(int)          | 设置格式宽度 | I/O  |
| setfill(ch)        | 填充         | I O  |
| setbase()          | 进制         | O    |
| ws                 | 跳过空格     | I    |
| setprecision(int)  | 精度         | O    |
| setioflags(long)   | 设置ioflag   | IO   |
| resetioflags(long) | 复位         | IO   |

* ioflag

| flag                 | purpose              |
| -------------------- | -------------------- |
| ios::skipws          | 跳过空格             |
| ios::left   or right | justofocation        |
| intenal              | 符号和值之间填充     |
| dec oct hex          | 10 16 8              |
| showbase             | 进制                 |
| showpoint            | 小数点               |
| uppercase            | 大写                 |
| showpos              | 加上+在正数前        |
| scientific fixed     | 格式化浮点           |
| unitbuf              | 任何时候都使用刷新写 |



## STL

[文档1](http://c.biancheng.net/stl/)          

[文档2](http://www.cplusplus.com/reference/)

* sort函数
  * #include algorithm

```C++
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{
    int arr[10] = {1, 3, -3, -9 ,6 ,9 ,11};
    sort(arr, arr+7);
    for (int i = 0; i < 7; i++)
        cout << arr[i] << " ";
    cout << endl;
    return 0;
}
```

### string 

* 相当于char *的封装

* 获取一行字符串   `string s = NULL;  getline(cin,s);`

```c++
    //切记不能初始化NULL
    std::string s;//执行默认构造函数
    std::string s = "";//执行拷贝构造函数
    
    
    string s = NULL;
    s+ = "hello";
    s+ = '5'
    s+ = 65;//对应大写A
    cout << s << endl;//打印结果 hello5A
```

* 对字符串排序

```c++
string = "5418345";
sort(s.begin(), s.end());
cout << s << endl;
```

* erase() 删除某字符
  * `s.erase(s.begin())`
* `substr(index, size);//`子字符串，size 正数取size个，size 负数倒取

* string 转数字

```c++
//sstream
string s = "1234";
int i;
stringstream ss;
ss << s;
s >> i;

//atoi
int i = stoi(s);
```



### vector

```c++
vector<int> v;//空
vector<int> v2(4);//4个初始化0
vector<int> v3(4, 6);// 初始为6

vector<int> v(9, 10);
for (auto i:v)  cout << i << " ";
cout << v[1];//索引1
cout << v.at(2);//索引2
v.push_back(5);// 5放进v的末端
v.resize(10); //默认为0
v.erase(10);//删除元素10,复杂度O(n)
cout << v.front();//头
cout << v.back(); //尾
sort(v.begin(), v.end());
sort(v.begin(), v.end(), greater<int>());//从大到小


```

### stack

```c++
#include <stack>

stack<int> s;//构造器
s.push();
s.top();//不弹出
s.pop();
s.size();
s.empty();
//方便用栈进制转换
```

### queue

```
#include <queue>

queue<int> q;
q.push(5);
q.front();
q.pop();
q.size();

```

### map

```c++
#include <map>
//有序的，树状结构
map<int, int> m;
//unorderd_map无序的，哈希结构

```

### set

```c++
set<int> s;//树状结构
s.insert(3);
s.size();

```

### deque

```c++
deque<int> d;
d.push_back(3);
d.push_front(4);
d.pop_back();
d.pop_front();
```

### list

```c++
list<int> li;//
li.push_back(6);
li.emplace_front(5);
li.insert(++li.begin(),2);

```





# C语言回忆

## 函数指针

* 每一个函数都有地址

```c
void f(int i)
{
    printf("in f()  i=%d\n", i);
}
void g(int j)
{
    
}
int main()
{
    int i = 0;
    void (*pf)(int) = f;
    f(3);
    (*pf)(4);
    
    //不推荐
    switch(i)
    {
        case 0:f(0);break;
        case 1:g(2);break;
    }
    
    //推荐
    void (*pff[])(int) = {f, g};
    scanf("%d", &i);
    if (i>=0 i<sizeof(fa)/sizeof(fa[0])){
        (*pff[i])(0);
    }
    return 0;
}
```

```c
int plus(int a, int b)
{
    return a + b;
}
int minus(int a, int b)
{
    return a - b;
}
int cal(int (*f)(int, int), int a, int b)
{
    printf("%d\n",(*f)(a,b));
}
```

