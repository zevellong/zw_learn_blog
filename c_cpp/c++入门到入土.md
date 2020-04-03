# c++入门到入土



## 2020-4-2 15:59

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

