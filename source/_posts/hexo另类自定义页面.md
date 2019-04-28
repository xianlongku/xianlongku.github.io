title: 另类的  Hexo自定义页面
author: MoXin
tags:
  - hexo
categories:
  - 笔记
date: 2018-04-09 11:27:00
---
需求：使用hexo编写可配置、可使用HTML5编程的自定义页面

思路：hexo根目录source中创建模版文件比如：custom/life/index.md，修改主题模板中page.ejs文件自动导向不同的custom下面得文件夹中的index.md，创建customhtml.ejs，在这里面使用ajax获取页面内容append到页面中..

<!--more-->

需要：

1. 博客框架 -- hexo
2. 主题末班 -- [Material X](https://xaoxuu.com/wiki/material-x/index.html)
3. 修改hexo中_config.yml、修改主题文件 Material X中 _config.yml、修改主题文件中layout/page.ejs、添加customhtml.ejs

具体：

1. source中创建custom文件夹，并且创建你要自定义的页面模版。创建customhtml文件夹，这里是存放你的html页面的
   ![](https://xianlongku.gitee.io/pic/2019/4/hexocustom-001.jpg)
2. 修改hexo _config.yml 中 skip_render: customhtml/**
3. 在hexo _config.yml 添加新的对象 custom 
   ![](https://xianlongku.gitee.io/pic/2019/4/hexocustom-002.jpg)
4. 主题模版下修改layout/page.ejs
    ```
      <% if (page.layout == "custom"){ %>
        <%- partial('customhtml', {post: page, config:config}) %>
      <% }else{ %>
        <div class='l_main<%- page.sidebar == false ? ' no_sidebar' : '' %>'>
          <%- partial('_partial/article', {post: page, index: false}) %>
        </div>
        <%- partial('_partial/side') %>
        <%- partial('_partial/footer', null, {cache: !config.relative_link}) %>
      <% } %>
    ```
5. 主题模版下layout添加customhtml.ejs
     ```
       <% var customUrl = config.custom[post.customtype] %>
       <% var customType = post.customtype %>
       <div id="custom-content" data-heft='<%- customUrl %>'>
           hello,这里是电影模版呀。。
       </div>
       
       <script>
           console.log(123);
       </script>
     ```
4. 上述custmhtml.ejs 可以使用ajax方法获取链接，加载到id位custom-content 中实现另类得自定义页面
5. 结果如下
   ![](https://xianlongku.gitee.io/pic/2019/4/hexocustom-003.jpg)
6. 目前不知道有什么问题，所有如果有朋友这么尝试过的话，有问题可以留言..
7. 或者有更好的办法，教教菜鸡的我.







