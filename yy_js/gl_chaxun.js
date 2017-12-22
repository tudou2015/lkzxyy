$(document).ready(function() {
	$("#button_chaxun").click(function() {
		//      $("div").load("../images/loading.gif");
		//if (checkLkjs()&&checkNumber()&&checkPhone()&&checkBeizhu()) {
		if (checkEditor()) {
			//alert("hello,world");
			var data3 = {					
				name_editor_chaxun:$("#name_editor_chaxun").val(),				
			};
			$.ajax({
				type: "post", //客户端向服务器发送请求时采取的方式                                 
				url: "yy_ajax/gl_chaxun.ashx",
				data: data3,
				dataType: "html",// "text",        
				error: function() { alert("服务器异常"); },
				success: function(result) {//客户端调用服务器端方法成功后执行的回调函数  
				//alert(result);
					//var json = eval(result); //ashx防止返回的不是json而是字符串,eval("("+ data +")")					
					var json3 = result.split("##");
					//alert(json2[1]);
					//var json=eval("("+ result +")");
					//var json=eval('('+ result +')');//转换为json对象
					//var json=result.parseJSON();
					//Object obj=Object.Parse(result);
					//string json=obj["entry"]["success"].toString();
					//string hqbjry=obj["entry"]["hqbjry"].toString();
					//alert(json.key);
					//var json=result; 					
					//if (json[0] == "1") {	
					if (json3[0] == "1") {						
						//alert("查询成功");
						//$(#Label3).html()=json[1];
						//alert(json2[1]);
						var obj = eval(json3[1]);
						//alert(obj);
						var count=obj.length;
						var items=document.getElementById("items_gl_chaxun").getElementsByTagName("li");
						//var items_canshu=document.getElementById("items").getElementsByTagName("span");
						for(var i=0;i<count;i++){								
							items[i].innerHTML=obj[i].bianma_liushui+" "+obj[i].jneirong+" "+obj[i].lkjs+" "+obj[i].phone+" <a target=_blank href='./yy_ajax/yy_download.ashx?file1="+obj[i].file1+"'>"+obj[i].file1+"</a> "+obj[i].editor2;
							//items_canshu[i].innerHTML=obj[i].file1;
							}
						
					}
					else {
						if (json3[0] == "0") {
							alert("预约失败");
							//window.parent.self.location.href="default.aspx";
						}
						if (json3[0] == "5") {
							alert("没有这个手机号的相关资源，请核实后再输入");
						}
						if (json3[0] == "2") {
							alert("晕菜了");
						}
						if (json3[0] == "3") {
							alert("时间段已被占用,请重新选择时间段");
						}
						else {
							alert("输入格式不规范，或含有危险字符，已被记录");
						}
					}
				}				
			});
			return false;
		}
		else {
			// checkXm_student();
			//checkXuehao_student();
			//checkSfzh_student();
			//checkDate();
			//checkSjd();
			//alert("请选择将来的时间");
			//alert("哪里出错了");
		}
	});
	
	 //check Editor 
    function checkEditor() {
        if ($("#name_editor_chaxun").val().length == 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			alert("后期制作人员姓名不能为空");			
            return false;
			 //return true;
        }
        else {
            var reg = /^\d{3}$|^[\u4e00-\u9fa5A-Za-z]{2,5}$/; //ok
            if (!reg.test($("#name_editor_chaxun").val())) {
                //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
				alert("后期制作人员姓名格式有误");
                return false;
				//return true;
            }
            else {
                //$("#xingmin_zhuce").next("span").css("color", "red").text("");
                return true;
            }
        }
    }
	
	
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
        if ($("#phone_chaxun").val().length == 0) {
            //$("#phone").next("span").css("color", "red").text("不能为空");
			alert("手机号码不能为空");
            return false;
			 //return true;
        }
        else {
            var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; //ok
            if (!reg.test($("#phone_chaxun").val())) {
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