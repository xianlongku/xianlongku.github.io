title: 搭建一个基于vue + vue-router+vuex+elementui的后台管理系统 (第一部门)
author: MoXin
tags:
  - vue
categories:
  - 笔记
date: 2018-04-09 11:27:00
---

##### 一、使用vue-cli搭建基础项目环境

1. 安装vue-cli

	```
npm install –global vue-cli  注：--global 是全局的意思
```
<!--more-->

	![](http://39.107.119.146/usr/uploads/2019/04/3119651631.png)
	
	（注：我安装过了，所以就这个样子了。）
2. 使用webpack 和vue-cli 初始化一个项目
> 如：vue init webpack bmsTemplate   （bmsTemplate 就是项目路径，下面还输入项目名称，不能大写！）

	接下来依次是
	
	![](http://39.107.119.146/usr/uploads/2019/04/1169771059.png)
	
	（中间好几个build是因为里面有一步是选择开发环境还是生产环境的包，上下切换导致的~）

3. 耐心等待npm安装项目依赖，安装完成如下

	![](http://39.107.119.146/usr/uploads/2019/04/1327213678.png)
4. 使用上面提示的命令尝试启动这个项目

	![](http://39.107.119.146/usr/uploads/2019/04/3871240549.png)![](http://39.107.119.146/usr/uploads/2019/04/1576833322.png)
5. 复制http://localhost:8080/#/ 到浏览器就可以看到如下，就说明项目创建成功了

	![](http://39.107.119.146/usr/uploads/2019/04/1637906595.png)

------------


##### 二、梳理项目结构，安装elementui框架插件
1. 梳理项目结构
	![](http://39.107.119.146/usr/uploads/2019/04/3673944115.png)
	
	src是项目整体的开发区域，基本上所有得开发代码都放在这里面
	
	node_modules：是项目依赖
	
	main.js：入口实例化vue对象，导入初始页面App和所需的项目环境
	
	![](http://39.107.119.146/usr/uploads/2019/04/1592236309.png)
 惑1、Vue.config.productionTip = false 是干嘛的
 惑2、router单独一行，js对象不应该是 router：router 么（是一个写法）
![](http://39.107.119.146/usr/uploads/2019/04/3070660178.png)
	惑1、<router-view/> 这个玩意是对应的默认路由吗？
	
	Router/index.js：路由管理
	![](http://39.107.119.146/usr/uploads/2019/04/2958295339.png)
	惑：path:’/’是默认路由吗？
2. 安装elementui
	```
npm i element-ui –S
```
安装前：
![](http://39.107.119.146/usr/uploads/2019/04/371736181.png)
安装成功后：
![](http://39.107.119.146/usr/uploads/2019/04/3908482976.png)