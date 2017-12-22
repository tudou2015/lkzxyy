$(document).ready(function() {
	$("#button_hqyy").click(function() {
		//      $("div").load("../images/loading.gif");
		//if (checkLkjs()&&checkNumber()&&checkPhone()&&checkBeizhu()) {
		if (checkLkjs()&&checkNumber()&&checkPhone()) {
			//alert("hello,world");
			var data2 = {	
				lkjs_hq:$("#lkjs_hq").val(),
				number_hq:$("#number_hq").val(),
				phone_hq:$("#phone_hq").val(),
				beizhu_hq:$("#beizhu_hq").val(),
			};
			$.ajax({
				type: "post", //客户端向服务器发送请求时采取的方式                                 
				url: "yy_ajax/yy_hq.ashx",
				data: data2,
				dataType: "html",// "text",        
				error: function() { alert("服务器异常"); },
				success: function(result) {//客户端调用服务器端方法成功后执行的回调函数  
				//alert(result);
					//var json = eval(result); //ashx防止返回的不是json而是字符串,eval("("+ data +")")					
					var json = result.split("##");
					//var json=eval("("+ result +")");
					//var json=eval('('+ result +')');//转换为json对象
					//var json=result.parseJSON();
					//Object obj=Object.Parse(result);
					//string json=obj["entry"]["success"].toString();
					//string hqbjry=obj["entry"]["hqbjry"].toString();
					//alert(json.key);
					//var json=result; 					
					//if (json[0] == "1") {	
					if (json[0] == "1") {						
						alert("预约成功,本次预约流水号："+json[2]+"后期编辑："+json[1]+"会尽快与您联系。");
						//$(#Label3).html()=json[1];
						document.getElementById("hqbjry").innerHTML=json[1];
						document.getElementById("number_hq").innerHTML="0";
						//document.getElementById("hqbjry2").innerHTML="<%= Session["hqbjry"]%>";
						//document.getElementById("hqbjry").innerHTML=<%= Session["hqbjry"]%>;
						//document.getElementById("Label3").value=json[1];
						//window.parent.self.location.href="yy.aspx#yy_hq";                             
						//$("#lean_overlay").fadeOut(200);
						//$("#OpenWindow_student").css({'display':'none'});
						//        		        //$($(this).attr("href")).css({ 'display' : 'none' });
					}
					else {
						if (json[0] == "0") {
							alert("预约失败");
							//window.parent.self.location.href="default.aspx";
						}
						if (json[0] == "5") {
							alert("没有这个用户名，请与资源中心联系");
						}
						if (json[0] == "2") {
							alert("晕菜了");
						}
						if (json[0] == "3") {
							alert("时间段已被占用,请重新选择时间段");
						}
						else {
							alert("输入格式不规范，或含有危险字符，已被记录");
						}
					}

				}
			});
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
		return false;
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
        if ($("#phone_hq").val().length == 0) {
            //$("#phone").next("span").css("color", "red").text("不能为空");
			alert("手机号码不能为空");
            return false;
			 //return true;
        }
        else {
            var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; //ok
            if (!reg.test($("#phone_hq").val())) {
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