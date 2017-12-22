$(document).ready(function() {
	$("#button_yy").click(function() {
		//      $("div").load("../images/loading.gif");
		if (checkDate()&&checkSjd()&&checkLkjs()&&checkPhone()&&checkXmzrr()&&checkKcmc()&&checkBeizhu()&&checkDrag()) {
			var data1 = {
				xmmc:$("#xmmc").val(),
				xmzrr:$("#xmzrr").val(),
				cjbm:$("#cjbm").val(),				
				date: $("#date").val(),
				sjd: $("#sjd").val(),
				kcmc:$("#kcmc").val(),
				lkjs:$("#lkjs").val(),
				phone:$("#phone").val(),
				beizhu:$("#beizhu").val(),
			};
			$.ajax({
				type: "post", //客户端向服务器发送请求时采取的方式                                 
				url: "yy_ajax/yy_zhuce.ashx",
				data: data1,
				dataType: "html",// "text",        
				error: function() { alert("服务器异常"); },
				success: function(result) {//客户端调用服务器端方法成功后执行的回调函数  
					//var json = eval(result); //ashx防止返回的不是json而是字符串
					var json = result.split("##");					
					if (json[0] == "1") {
						alert("预约成功,请记住您的流水编号"+json[1]+"以便查询制作进度");
						window.parent.self.location.href="yy.aspx";                             
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
						if (json[0] == "7") {
							alert("数据库异常,无法识别资源制作人员");
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
			//return false;
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

	  //check xmzrr
    function checkXmzrr() {
        if ($("#xmzrr").val().length == 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			alert("项目责任人不能为空");			
            return false;
			 //return true;
        }
        else {
            var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/; //ok
            if (!reg.test($("#xmzrr").val())) {
                //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
				alert("项目责任人格式有误");
                return false;
				//return true;
            }
            else {
                //$("#xingmin_zhuce").next("span").css("color", "red").text("");
                return true;
            }
        }
    }
	//check yuyue sjd
	function checkDate() {
		//alert("进入日期判断");
		var ss=new Array([3]);
		ss=$("#date").val().split("-");
			var dt = new Date($("#date").val());  
			//alert(dt.getDay());  
			//var ss4=dt.getDay();
			//var ss5=theWeek();
		var ss1=ss[0];
		var ss2=ss[1];
		var ss3=ss[2];
		
		var ss5=getYearWeek(ss1,ss2,ss3);
		//alert(ss5);
		
		var ss_now=new Date();
		$("#nowdate").next("span").css("color", "red").text=ss_now;
		var ss_now_year=ss_now.getFullYear();
		var ss_now_month=ss_now.getMonth()+1;
		var ss_now_day=ss_now.getDate();	
		//var ss_now_week=ss_now.getDay();
		var ss_now_week_year=theWeek_now();
		//if(ss_now_week=0){ss_now_week=7;}
		//选择下周日期
		//if((ss1>=ss_now_year)&&(ss2>=ss_now_month)&&(ss3>ss_now_day)&&(ss5>ss_now_week_year)){
		//选择4天后续推6天的日期	
		//if((ss1>=ss_now_year)&&(ss2>=ss_now_month)&&(ss3>(ss_now_day+3))&&(ss3<(ss_now_day+10))){
		if(ss1==2017&&ss2==5&&ss3==10){
					alert("请选择其他日期,2017年5月10日是资源中心体检日。");
					return false;
		}
			/*if(date.getDay()==6||date.getDay()==0){//这里不对，
				return false;
				alert("请选择工作日");
			}
			else{
				return true;
			}*/
			//alert("日期可选择");
			//var ss_now_week=theWeek();
			//alert(ss_now_week_year);
			//alert(ss5);
			//return true;
				
		//}
		else{
			//alert("请选择下周之后的时间");
			//alert("请选择有效日期");
			//return false;	
			return true;
			
		}
		
	}
	function checkSjd(){
		//alert("进入时间段判断");
		return true;
	}
	//check kcmc
	 function checkKcmc() {
        if ($("#kcmc").val().length == 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
            alert("课程名称不能为空");
            return false;
            //return true;
        }
        else {
            var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,30}$/; //ok
            if (!reg.test($("#kcmc").val())) {
                //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
                alert("课程名称格式有误");
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
        if ($("#lkjs").val().length == 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			alert("录课教师不能为空");			
            return false;
			 //return true;
        }
        else {
            var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/; //ok
            if (!reg.test($("#lkjs").val())) {
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
	 //check phone
    function checkPhone() {
        if ($("#phone").val().length == 0) {
            //$("#phone").next("span").css("color", "red").text("不能为空");
			alert("手机号码不能为空");
            return false;
			 //return true;
        }
        else {
            var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; //ok
            if (!reg.test($("#phone").val())) {
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
        if ($("#beizhu").val().length != 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			//alert("项目责任人不能为空");	
			var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,50}$/; //ok
            if (!reg.test($("#beizhu").val())) {
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
	
	//判断拖动是否成功
	function checkDrag(){
		/*drag_color=$("#drag").css("background-color");//rgb(232,232,232)
		//$(#drag).dr.css("background-color");
		//alert(drag_color);
		if(drag_color!=rgb(232,232,232)){return true;}
		else {alert("请拖动滑块完成验证");return false;}*/
		if($("#Label2").html()=="验证成功"){
			//alert("识别到验证成功字");
			return true;
			}
		else{
			alert("请拖动滑块完成验证");
			return false;
			}
		//return true;
		
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////
//获取当前日期在当前年第几周函数封装，例如2013-08-15 是当前年的第32周
////////////////////////////////////////////////////////////////////////////////////////////////////
function theWeek_now() {
    var totalDays = 0;
    now = new Date();
    years = now.getYear()
    if (years < 1000)
        years += 1900
    var days = new Array(12);
    days[0] = 31;
    days[2] = 31;
    days[3] = 30;
    days[4] = 31;
    days[5] = 30;
    days[6] = 31;
    days[7] = 31;
    days[8] = 30;
    days[9] = 31;
    days[10] = 30;
    days[11] = 31;
     
    //判断是否为闰年，针对2月的天数进行计算
    if (Math.round(now.getYear() / 4) == now.getYear() / 4) {
        days[1] = 29
    } else {
        days[1] = 28
    }
 
    if (now.getMonth() == 0) {
        totalDays = totalDays + now.getDate();
    } else {
        var curMonth = now.getMonth();
        for (var count = 1; count <= curMonth; count++) {
            totalDays = totalDays + days[count - 1];
        }
        totalDays = totalDays + now.getDate();
    }
    //得到第几周
    var week = Math.round(totalDays / 7);
	//var week = Math.ceil(totalDays / 7);
    return week;
}

var getYearWeek = function (a, b, c) { 
    var d1 = new Date(a, b-1, c), d2 = new Date(a, 0, 1), 
    d = Math.round((d1 - d2) / 86400000); 
    return Math.ceil((d + ((d2.getDay() + 1) - 1)) / 7); 
};
//alert(getYearWeek(2010, 10, 13));
	
});
   
 