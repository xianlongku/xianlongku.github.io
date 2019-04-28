title: bootstrapNavL
tags:
  - bootstrap
categories:
  - 笔记
date: 2019-04-10 10:03:00
---

```
/**
 * 基于bootstrap的Nav导航菜单
 * ps:每次搭建项目每次写一个，神烦，so 封装一个
 */

;(function($) {
	$.fn.bootstrapNavL = function(options){
		//插件默认值
		var defaluts = {
			content:"#content",
			isTtielText:"财务报账服务平台",
			width: '220px',
			backgroundColor: 'blue',
			defalutsArray:[
				{
					href:"html/zizhuchaxun/gerenfapiaozizhu.html",
					iconClass:"fa fa-fw fa-folder",
					text:"个人发票",
					child:[]
				},
				{
					href:"html/gerenbaoxiao/gerenbaoxiao.html",
					iconClass:"fa fa-fw fa-plus",
					text:"个人报销",
					child:[]
				},
				{
					href:"html/zizhuchaxun/chaxunshouye.html",
					iconClass:"fa fa-fw fa-dropbox",
					text:"自助查询",
					child:[
						{
							href:"html/zizhuchaxun/chaxunshouye.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"查询首页",
							child:[]
						},
						{
							href:"html/zizhuchaxun/edu.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"额度查询",
							child:[]
						},
						{
							href:"html/zizhuchaxun/lishibaoxiaodan.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"历史报销单查询",
							child:[]
						},
						{
							href:"html/zizhuchaxun/shenpjindu.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"审批进度查询",
							child:[]
						}
					]
				},
				{
					href:"",
					iconClass:"fa fa-fw fa-dropbox",
					text:"对公报销",
					child:[
						{
							href:"test2.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"报销对公",
							child:[]
						}
					]
				},
				{
					href:"",
					iconClass:"fa fa-fw fa-dropbox",
					text:"个性设置",
					child:[
						{
							href:"html/settings/latitudeTemplate.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"纬度模板设置",
							child:[]
						},
						{
							href:"html/settings/reimbursementScene.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"报销场景设置",
							child:[]
						},
						{
							href:"html/settings/agencyReimbursement.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"代理报销设置",
							child:[]
						}
					]
				},
				{
					href:"",
					iconClass:"fa fa-fw fa-dropbox",
					text:"报销审批",
					child:[
						{
							href:"test.html",
							iconClass:"fa fa-fw fa-twitter",
							text:"报销流程",
							child:[]
						}
					]
				}
			]
		};
		//合并默认值和传进来的值
		var opts = $.extend({},defaluts,options);
		this.data("opts",opts);
		//如果是字符串，就是代表调用方法
		if (typeof options == 'string') {
		    return $.fn.bootstrapNavL.methods[options](this, $.fn.bootstrapNavL);
		}
		
		//开始流程
		//1 创建基于bootstrap的Nav dom
		var navDom = commonMethods.creatNav(this);
	    //2 使用递归加载里面ul 和li
		var navUl = $('<ul class="nav sidebar-nav"></ul>');
		navDom.append(navUl);
		//如果需要Title的话就显示出来
		if(opts.isTtielText!="" && opts.isTtielText!=null){
			var navTitle = $('<li class="sidebar-brand"><a href="#">'+opts.isTtielText+'</a></li>');
			navUl.append(navTitle);
		}
		//这里创建Dom树的入口
		commonMethods.creatUlLi(navUl,defaluts.defalutsArray,this,0);
		//将opts绑定到当前插件对象上，方便其他地方获取
	};
	//使用闭包，设置封装常用方法
	var commonMethods = (function(){
		return {
			creatNav:function(t){
				var navDom = $('<nav class="navbar navbar-inverse navbar-fixed-top sidebar-wrapperLL" '+
				' role="navigation"></nav>');
				t.append(navDom);
				return navDom;
			},
			/**
			 * childLayer 菜单层级
			 */
			creatUlLi:function(t,liArray,that,childLayer){
			
				if(liArray.length>0){
					//初始为0 ,只要迭代一次 就说明多一层
					childLayer++;
					//循环创建一级菜单的Li
					for(var i = 0 ;i < liArray.length;i++){
						var navLi = $('<li><a class="fu" data-childLayer="'+childLayer+'" data-stopPropagation="true" data-href="'+liArray[i].href+'" href="#">'+
						'<i class="'+liArray[i].iconClass+'">'+
						'</i> '+liArray[i].text+'</a></li>');
						//绑定点击事件确认选中状态，并且将页面append到content中
						commonMethods.liOnClick(navLi,that);
						t.append(navLi);
						var childPadding = (childLayer-1) * 16 + 30;
						
						if(childLayer!="1"){
							navLi.find("a").css('padding-left',childPadding+"px");
						}
						//存在二级菜单的，递归append
						if(liArray[i].child.length>0){
							/*这里是一级和二级的属性和class不同，单独添加
							注意：data-stopPropagation 不能添加到一级菜单，这里是二级菜单创建，
							data-href 也不能存在
							*/
							navLi.addClass("dropdown")
							.on("click",function(){
								//这里使用点击事件来控制折叠
								that.find("li.open").removeClass("open");
								$(this).toggleClass("open");
							})
							.find("a")
							.addClass("dropdown-toggle")
							//.attr("data-toggle","dropdown")
							.removeAttr("data-stopPropagation")
							.removeAttr(" data-href")
							
							
							if(childLayer == "1" && i==0){
								navLi.addClass("open");
							}
							var navUl = $('<ul class="dropdown-menu" role="menu"></ul>');
							navLi.append(navUl);
							commonMethods.creatUlLi(navUl,liArray[i].child,that,childLayer);
						}else{
							continue;
						}
			
						//这里是dom全部加载完成之后
						if(childLayer == "1" && i == liArray.length-1){
							console.log("这里是执行完毕咯~")
							commonMethods.selectNavAndShowContent(that);
						}
						
					}
				}
				
			},
			liOnClick:function(li,that){
				li.find("a").on("click",function(){
					commonMethods.selectNavAndShowContent(that,this);
					
				});
			},
			/**
			 * 第一参数是最大的bootstrapNavL对象
			 * 第二参数是用语点击事件的当前对象（只有点击事件的时候才会用）
			 */
			selectNavAndShowContent:function(that,t){
			
				that.find("a.select").removeClass("select");
				that.find("li.dropdown.open").removeClass("open");
				var aHref = "";
				if ( t != null && t!=undefined) {
					$(t).addClass("select");
					aHref = $(t).attr("data-href");
				} else{
					aHref = that.find("a[data-href]").first().addClass("select").data("href");
					
				}

				if(aHref != "" && aHref!=undefined){
					//如果不是 underfined  则说明点击得不是包含二级菜单的一级菜单， 可以append
					
					 $.get(aHref,
							  function(data){
							  $($(that).data("opts").content).empty().append(data);
					}); 
				}
			}
			
		}
	})()
	
	//对外公布得方法
	$.fn.bootstrapNavL.methods={
		getOptions:function(that){
			return that.data("opts");
		}
	}
	
})(jQuery)
```

