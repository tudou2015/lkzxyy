$(document).ready(function() {
	flag=false;
	count_bb=0;
	count_cc=0;
	$("#button_chaxun_ly").click(function() {		
		if (checkPhone()) {
			//alert("hello,world");
			var data5 = {					
				phone_chaxun_yy:$("#phone_chaxun_yy").val(),				
			};
			$.ajax({
				type: "post", //客户端向服务器发送请求时采取的方式                                 
				url: "yy_ajax/yy_chaxun_ly.ashx",
				data: data5,
				dataType: "html",// "text",        
				error: function() { alert("服务器异常"); },
				success: function(result) {//客户端调用服务器端方法成功后执行的回调函数  
				//alert(result);
					//var json = eval(result); //ashx防止返回的不是json而是字符串,eval("("+ data +")")					
					var json5 = result.split("##");
					//alert(json2[1]);				
					//alert(json.key);					
					if (json5[0] == "1") {						
						//alert("查询成功");
						//$(#Label3).html()=json[1];
						//alert(json2[1]);
						var obj = eval(json5[1]);
						//alert(obj);
						var count=obj.length;
						count_bb=obj.length;											
						//public static var count_shang=obj.length;
						var items=document.getElementById("items5").getElementsByTagName("li");						
						for(var i=0;i<count;i++){								
							items[i].innerHTML=obj[i].lkjs+" "+obj[i].date+" "+obj[i].week+" "+obj[i].sjd+" "+obj[i].phone;							
						}
							flag=true;
						if(flag&&count_bb<count_cc){
							for(var i=count_bb;i<count_cc;i++){								
								items[i].innerHTML="";						
							}
						}
					}
					else {
						if (json5[0] == "0") {
							alert("预约失败");
							//window.parent.self.location.href="default.aspx";
						}
						if (json5[0] == "5") {
							alert("没有这个手机号的有关录制预约记录");
						}
						if (json5[0] == "2") {
							alert("晕菜了");
						}
						if (json5[0] == "3") {
							alert("时间段已被占用,请重新选择时间段");
						}
						else {
							alert("输入格式不规范，或含有危险字符，已被记录");
						}
					}

				}
				
			});
			//return false;
		}
		else {
		
		}
	});

	
	$("#button_chaxun_hq").click(function() {		
		if (checkPhone()) {
			//alert("hello,world");
			var data5 = {					
				phone_chaxun_yy:$("#phone_chaxun_yy").val(),				
			};
			$.ajax({
				type: "post", //客户端向服务器发送请求时采取的方式                                 
				url: "yy_ajax/yy_chaxun_hq.ashx",
				data: data5,
				dataType: "html",// "text",        
				error: function() { alert("服务器异常"); },
				success: function(result) {//客户端调用服务器端方法成功后执行的回调函数  
				//alert(result);
					//var json = eval(result); //ashx防止返回的不是json而是字符串,eval("("+ data +")")					
					var json5 = result.split("##");
					//alert(json2[1]);				
					//alert(json.key);					
					if (json5[0] == "1") {						
						//alert("查询成功");
						//$(#Label3).html()=json[1];
						//alert(json2[1]);
						var obj = eval(json5[1]);
						//alert(obj);
						var count=obj.length;
						count_cc=obj.length;											
						var items=document.getElementById("items5").getElementsByTagName("li");							
						for(var i=0;i<count;i++){								
							items[i].innerHTML=obj[i].bianma_liushui+" "+obj[i].jneirong+" "+obj[i].lkjs+" "+obj[i].editor2+" "+obj[i].completed;
						}	
							flag=true;
						if(flag&&count_cc<count_bb){
							for(var i=count_cc;i<count_bb;i++){								
							items[i].innerHTML="";						
							}
						}	
					}
					else {
						if (json5[0] == "0") {
							alert("预约失败");
							//window.parent.self.location.href="default.aspx";
						}
						if (json5[0] == "5") {
							alert("没有这个手机号的有关后期预约记录");
						}
						if (json5[0] == "2") {
							alert("晕菜了");
						}
						if (json5[0] == "3") {
							alert("时间段已被占用,请重新选择时间段");
						}
						else {
							alert("输入格式不规范，或含有危险字符，已被记录");
						}
					}

				}
				
			});
			//return false;
		}
		else {
		
		}
	});

   //check lkjs 
    function checkLkjs() {
        if ($("#lkjs_hq").val().length == 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			alert("录课教师不能为空");			
            return false;
			 //return true;
        }
        else {
            var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/; //ok
            if (!reg.test($("#lkjs_hq").val())) {
                //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
				alert("录课教师格式有误");
                return false;
				//return true;
            }
            else {
                //$("#xingmin_zhuce").next("span").css("color", "red").text("");
                return true;
            }
        }
    }
	
	//check number
	function checkNumber(){
		 if ($("#number_hq").val() == 0) {
            //$("#phone").next("span").css("color", "red").text("不能为空");
			alert("数量不能为0");
            return false;
			 //return true;
        }
		else{
             if ($("#number_hq").val() == ""||$("#number_hq").val() == null){
				 alert("请不要重复预约,如需再次预约请刷新页面");
			 }
			else{
				return true;				
			}
			
		}
		
		
	}
	//check phone
    function checkPhone() {
        if ($("#phone_chaxun_yy").val().length == 0) {
            //$("#phone").next("span").css("color", "red").text("不能为空");
			alert("手机号码不能为空");
            return false;
			 //return true;
        }
        else {
            var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; //ok
            if (!reg.test($("#phone_chaxun_yy").val())) {
                //$("#phone").next("span").css("color", "red").text("位数不对或不是有效号码");
				alert("请输入有效的手机号码");
				return false;
				//return true;
            }
            else {
                //$("#phone").next("span").css("color", "red").text("");
                return true;
            }
        }
    }
	
	 //check beizhu
    function checkBeizhu() {
        if ($("#beizhu_hq").val().length != 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			//alert("项目责任人不能为空");	
			var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,50}$/; //ok
            if (!reg.test($("#beizhu_hq").val())) {
                //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
				alert("备注请使用50个汉字以内");
                return false;
				//return true;
            }
            else {
                //$("#xingmin_zhuce").next("span").css("color", "red").text("");
                return true;
            }
            //return false;
			
        }
        else {
             return true;
        }
    }
	

});