---
typora-copy-images-to: images
typora-root-url: ./
---

# 说明
编写的 **pkg**管理个人脚本， **pkg** 可以在linux和cygwin上安装这些脚本。

**pkg安装mgo**

```
pkg install mgo
```

**pkg功能**

```
heer@FPGA-Use ~/page (master)# pkg help
 Install script!
pkg install script  安装script
pkg linstall script 安装script到当前目录
pkg mlist           列出所有资源
pkg find script     查找资源
pkg init            安装所有脚本
pkg help            显示帮助
```

# 获取pkg

使用以下命令安装 **pkg**

```shell
curl http://yuan_hp.gitee.io/page/pkg > ~/bin/pkg 
chmod +x ~/bin/pkg
```

# 主要依赖软件

* fish shell
* bash 
* gnuplot
* dot
* iverilog 



# 安装说明

## deepin

| 工具                                  | 功能                                                         | 安装命令               |
| ------------------------------------- | ------------------------------------------------------------ | ---------------------- |
| [mgo](./deepin/mgo)                   | 懒人执行脚本，执行run.sh/run.fish/run或者当前路径下最近修改的文件 | pkg install mgo        |
| [cdd.fish](./deepin/cdd.fish)         | 快速进入自己设定的一些目录，需要自己编辑，需要安装fish shell | pkg install cdd.fish   |
| [gitee.fish](./deepin/gitee.fish)     | 打开gitee，需要安装fish shell                                | pkg install gitee.fish |
| [github.fish](./deepin/github.fish)   | 打开github，需要安装fish shell                               | -                      |
| [mvsim](./deepin/mvsim)               | iverilog快速仿真管理脚本，需要安装iverilog                   | -                      |
| [new](./deepin/new)                   | 新建文件时的模板                                             | -                      |
| [readini.fish](./deepin/readini.fish) | 脚本读取ini文件                                              | -                      |
| [sea.fish](./deepin/sea.fish)         | 快速打开百度搜多关键词                                       | -                      |
| [topath.fish](./deepin/topath.fish)   | 快速将当前终端所在路径添加到fish环境变量                     | -                      |
| [web.fish](./deepin/web.fish)         | 快速打开某些网页，使用 web -h 查看帮助                       | -                      |
| [math.dft](./deepin/math.dft)         | 对文件数据进行离散傅里叶变换，Use: math.dft filename [fs]    | -                      |
| [math.dftp](./deepin/math.dftp)       | 对文件数据第n列进行离散傅里叶变换，Use: math.dft [-f] () [-c] () filename | -                      |
| [math.ave](./deepin/math.ave)         | 求文件第n列的数据平均值 Use: math.ave filename [column]      | -                      |
| [math.max](./deepin/math.max)         | 求文件第n列的数据最大值 Use: math.max filename [column]      | -                      |
| [math.maxabs](./deepin/math.maxabs)   | 求文件第n列的数据绝对值最大值的原数据 Use: math.maxabs filename [column] | -                      |
| [math.minabs](./deepin/math.minabs)   | 求文件第n列的数据绝对值最小值的原数据 Use: math.minabs filename [column] | -                      |
| [math.min](./deepin/math.min)         | 求文件第n列的数据最小值 Use: math.min filename [column]      | -                      |
| [math.s](./deepin/math.s)             | 求文件第n列的数据最标准差 Use: math.s filename [column]      | -                      |
| [math.ss](./deepin/math.ss)           | 求文件第n列的数据最方差 Use: math.ss filename [column]       | -                      |
| [math.sum](./deepin/math.sum)         | 求文件第n列的数据和 Use: math.sum filename [column]          | -                      |
| [mplot](./deepin/mplot)               | 调用gnuplot绘图  例如： math.dft m.dat \| mplot -d 1:2       | -                      |
| [math.tan](./deepin/math.tan)         | 计算tan值，例如 math.tan 12                                  | -                      |
| [math.atan](./deepin/math.atan)       | 计算反tan值，例如 math.atan 12                               | -                      |
| [math.cos](./deepin/math.cos)         | 计算tcos值，例如 math.cos 12                                 | -                      |
| [math.ln](./deepin/math.ln)           | 计算ln值，例如 math.ln12                                     | -                      |
| [math.log](./deepin/math.log)         | 计算log10(x)值，例如 math.log 12                             | -                      |
| [uhelp](./deepin/uhelp)               | 显示pkg安装的脚本以及功能                                    | -                      |
| [mgpp](./deepin/mgpp)                 | g++版本管理                                                  | -                      |
| [mgcc](./deepin/mgcc)                 | gcc版本管理                                                  | -                      |
| [mfit](./deepin/mfit)                 | 最小二乘法拟合文件，Use: mfit filename , 数据1 2列 => x y    | -                      |

