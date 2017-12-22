<%@ page language="C#" autoeventwireup="true" inherits="upload, App_Web_3rnbkrrj" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, width=device-width,user-scalable=no" />
    <title>无标题页</title>  
<link href="yy_css/jquery.mobile-1.4.5.css" rel="Stylesheet" type="text/css" />
<script src="yy_js/jquery-2.2.4.js" type="text/javascript"></script>
<script src="yy_js/jquery.mobile-1.4.5.js" type="text/javascript"></script>
<%--<script src="js_yy/upload.js" type="text/javascript"></script>--%>
<%--<script src="js_yy/yy_upload.js" type="text/javascript"></script>--%>
<script type="text/javascript">
    //判断访问终端
    var browser = {
        versions: function() {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
                iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
                weixin: u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
                qq: u.match(/\sQQ/i) == " qq" //是否QQ
            };
        } (),
        language: (navigator.browserLanguage || navigator.language).toLowerCase()
    }
</script>
  <script type="text/javascript">
      function fileSelected() {
          //      <!--[if IE 9]> 仅IE9可识别 <![endif]-->
          if (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion.split(";")[1].replace(/[ ]/g, "").replace("MSIE", "")) < 9) {
              //              alert("您的浏览器版本过低，请下载IE9及以上版本");
              var file = document.getElementById('fileToUpload');
          }
          else { 
              var file = document.getElementById('fileToUpload').files[0];
          }          
           filename = file.name;
          //return filename;
          if(file){
              var fileSize = 0;
              if (file.size > 1024 * 1024)
                  fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
              else
                  fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
              document.getElementById('fileName').innerHTML = 'Name: ' + file.name;
              document.getElementById('fileSize').innerHTML = 'Size: ' + fileSize;
              document.getElementById('fileType').innerHTML = 'Type: ' + file.type;
          }
          return filename;
      }
      function uploadFile() {
          if(checkXmzrr()&&checkKcmc()&&checkJneirong()&&checkLkjs()&&checkPhone()&&checkBeizhu()&&checkfileToUpload()){
               var fd = new FormData();
              fd.append("xmmc_sc", $("#xmmc_sc").val());
              fd.append("xmzrr_sc", $("#xmzrr_sc").val());
              fd.append("cjbm_sc", $("#cjbm_sc").val());
              fd.append("kcmc_sc", $("#kcmc_sc").val());
              fd.append("jneirong_sc", $("#jneirong_sc").val());
              fd.append("lkjs_sc", $("#lkjs_sc").val());
              fd.append("phone_sc", $("#phone_sc").val());
              fd.append("editor_sc",$("#editor_sc").val());
              fd.append("beizhu_sc", $("#beizhu_sc").val());
              //var filename = file.name;
              var ext_sc = filename.substring(filename.lastIndexOf(".") + 1,filename.length);
              fd.append("extend_sc",ext_sc);
              fd.append("fileToUpload", document.getElementById('fileToUpload').files[0]);
              var xhr = new XMLHttpRequest();
              xhr.upload.addEventListener("progress", uploadProgress, false);
              xhr.addEventListener("load", uploadComplete, false);
              xhr.addEventListener("error", uploadFailed, false);
              xhr.addEventListener("abort", uploadCanceled, false);
              xhr.open("POST", "yy_ajax/yy_upload.ashx"); //修改成自己的接口
              xhr.send(fd);
          
          }
          else {
             // return false;
          
          }
//          checkXmmc();
//          checkXmzrr();
//          checkCjbm();
//          checkKcmc();
//          checkJneirong();
//          checkLkjs();
//          checkPhone();
//          checkBeizhu();         
         
      }
      function uploadProgress(evt) {
          if (evt.lengthComputable) {
              var percentComplete = Math.round(evt.loaded * 100 / evt.total);
              document.getElementById('progressNumber').innerHTML = percentComplete.toString() + '%';
          }
          else {
              document.getElementById('progressNumber').innerHTML = 'unable to compute';
          }
      }
      function uploadComplete(evt) {
          /* 服务器端返回响应时候触发event事件*/
          alert(evt.target.responseText);
      }
      function uploadFailed(evt) {
          alert("There was an error attempting to upload the file.");
      }
      function uploadCanceled(evt) {
          alert("The upload has been canceled by the user or the browser dropped the connection.");
      }
//      /**
//      * 侦查附件上传情况 ,这个方法大概0.05-0.1秒执行一次
//      */
//      function onprogress(evt) {
//          var loaded = evt.loaded;     //已经上传大小情况 
//          var tot = evt.total;      //附件总大小 
//          var per = Math.floor(100 * loaded / tot);  //已经上传的百分比 
//          $("#son").html(per + "%");
//          $("#son").css("width", per + "%");
      //      }
      function checkfileToUpload() {
          if ($("#fileToUpload").val().length == 0 | $("#fileToUpload").val() == "未选择任何文件") {
              //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
              alert("请选择上传文件");
              return false;
              //return true;
          }
          else {
          return true;
//              var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/; //ok
//              if (!reg.test($("#xmzrr_sc").val())) {
//                  //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
//                  alert("项目责任人格式有误");
//                  return false;
//                  //return true;
//              }
//              else {
//                  //$("#xingmin_zhuce").next("span").css("color", "red").text("");
//                  return true;
//              }
          }
      }
        function checkXmzrr() {
            if ($("#xmzrr_sc").val().length == 0) {
                //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
			    alert("项目责任人不能为空");			
                return false;
			     //return true;
            }
            else {
                var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/; //ok
                if (!reg.test($("#xmzrr_sc").val())) {
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

        function checkKcmc() {
            if ($("#kcmc_sc").val().length == 0) {
                //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
                alert("课程名称不能为空");
                return false;
                //return true;
            }
            else {
                var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,30}$/; //ok
                if (!reg.test($("#kcmc_sc").val())) {
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
        function checkJneirong() {
            if ($("#jneirong_sc").val().length == 0) {
                //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
                alert("讲内容不能为空");
                return false;
                //return true;
            }
            else {
                var reg = /^\d{3}$|^[\u4e00-\u9fa5A-Za-z0-9]{2,30}$/;  //ok
                if (!reg.test($("#jneirong_sc").val())) {
                    //$('#xingmin_zhuce').next("span").css("color", "red").text("格式有误");
                    alert("讲内容格式有误");
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
        if ($("#lkjs_sc").val().length == 0) {
            //$("#lkjs_").next("span").css("color", "red").text("不能为空"); 
			alert("录课教师不能为空");			
            return false;
			 //return true;
        }
        else {
            var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/; //ok
            if (!reg.test($("#lkjs_sc").val())) {
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
        if ($("#phone_sc").val().length == 0) {
            //$("#phone").next("span").css("color", "red").text("不能为空");
			alert("手机号码不能为空");
            return false;
			 //return true;
        }
        else {
            var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; //ok
            if (!reg.test($("#phone_sc").val())) {
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
    //check beizhu
    function checkBeizhu() {
        if ($("#beizhu_sc").val().length != 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
            //alert("项目责任人不能为空");	
            var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,50}$/; //ok
            if (!reg.test($("#beizhu_sc").val())) {
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

    </script>
</head>
<body>
<div data-role="page" id="yy_sc">

    <div data-role="header" >
        <h1>录制上传。。</h1>
    </div>    

    <div data-role="content">
          <p>录制完声音请上传</p>                
            
          <form id="form1" autocomplete="on" onsubmit="return false;">         
            <div class="row2">
              <label for="fileToUpload"></label>
              <input type="file" name="fileToUpload" id="fileToUpload" onchange="fileSelected();" autofocus="autofocus"/>
            </div>
            <div id="fileName"></div>
            <div id="fileSize"></div>
            <div id="fileType"></div>
            
             <span>项目名称</span>              
                <select id="xmmc_sc" >  
                <option>成教（皖西学院）</option>  
                <option>成教（华中科大）</option>              
                </select>    
                                
                <span>项目责任人</span>  
                <input type="text" id="xmzrr_sc" name="name_xmzrr" placeholder="请输入"/>
               
                <span>承建部门</span> 
                <select id="cjbm_sc"> 
                     <option>文法学院</option>
                     <option>经济与管理学院</option>
                     <option>信息与工程学院、农业与医疗卫生学院</option>
                     <option>教育科学学院 公共基础部 思想政治理论课教育教学部</option>
                     <option>城市建设学院</option>
                     <option>开放教育学院</option>
                     <option>网络教育学院</option>
                     <option>继续教育学院</option>
                     <option>远程教育中心</option>                    
                </select> 
                
                <span>课程名称</span>  
                <input type="text" id="kcmc_sc" name="name_kcmc" placeholder="请输入"/>
                               
                <span>讲内容</span>  
                <input type="text" id="jneirong_sc" name="name_jneirong" placeholder="请输入"/>
                
                <span>录课教师</span>  
                <input type="text" id="lkjs_sc" name="name_lkjs" placeholder="请输入"/>                               
               
                <span>联系电话</span>  
                <input type="text" id="phone_sc" name="phone_lkjs" placeholder="请输入"/><span></span>   
                
                <span>制作人员</span> 
                <select id="editor_sc"> 
                     <option>周锐</option>
                     <option>陈冬梅</option>
                     <option>朱悦</option>
                     <option>方圆</option>
                     <option>韩坤</option>
                     <option>赵玲</option>                                    
                </select>          
               
                <span>备注（如有特殊需要，请备注）</span>  
                <input type="text" id="beizhu_sc"><span></span>        
            
            
            <div class="row"> 
              <input type="submit" onclick="uploadFile()" value="Upload" id="button_upload"/>
            </div>
        </form>    
            <div id="progressNumber"></div>      
          
    </div>
    
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>"         
              SelectCommand="SELECT [bianma], [date], [week], [sjd], [kcmc], [jneirong], [phone], [lzr], [beizhu] FROM [lkzxyy] ORDER BY [date], [sjd]">
            </asp:SqlDataSource>
    
    <div data-role="footer" >
        <h4><a href="yy2.aspx">资源制作部@安徽电大</a></h4>
    </div>              

</div>  
    
</body>
</html>
