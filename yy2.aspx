<%@ page language="C#" autoeventwireup="true" inherits="_Default, App_Web_3rnbkrrj" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, width=device-width,user-scalable=no" />
    <title>资源录制在线预约</title> 
<link href="yy_css/jquery.mobile-1.4.5.css" rel="Stylesheet" type="text/css" />
<%--<link href="yy_css/drag.css" rel="Stylesheet" type="text/css" />--%>
<script src="yy_js/jquery-2.2.4.js" type="text/javascript"></script>
<script src="yy_js/jquery.mobile-1.4.5.js" type="text/javascript"></script>
<%--<script src="yy_js/yy.js" type="text/javascript"></script>--%>
<%--<script src="yy_js/yy_hq.js" type="text/javascript"></script>--%>
<script src="yy_js/gl_chaxun_hq.js" type="text/javascript"></script>
<script src="yy_js/gl_chaxun.js" type="text/javascript"></script>
<%--<script src="yy_js/yy_chaxun_ly.js" type="text/javascript"></script>--%>
<%--<script src="yy_js/yy_chaxun_gzjdd.js" type="text/javascript"></script>--%>
<script src="yy_js/jrender.js" type="text/javascript"></script>
<%--<script src="My97DatePicker/WdatePicker.js" type="text/javascript"></script>--%>
<%--<script src="yy_js/drag.js" type="text/javascript"></script>--%>
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
    function confirm_gzjd(i) {
        //var ii = i;
        var fd2 = new FormData();
        fd2.append("bianma_liushui", $("#bianma_liushui_" + i + "").html().trim());
        fd2.append("gzjd_hq", $("#gzjd_hq_"+i+"").val());
        fd2.append("completed_hq", $("#completed_hq_"+i+"").val());
        var xhr2 = new XMLHttpRequest();
        xhr2.open("POST", "yy_ajax/gl_chaxun_hq_gzjd.ashx"); //修改成自己的接口
        xhr2.send(fd2);

    }		
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
        if (file) {
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
//    $(document).ready(function(){
    function uploadFile(bianma_liushui,xmmc_sc,xmzrr_sc,cjbm_sc,kcmc_sc,lkjs_sc,phone_sc) {
        if (checkJneirong2() && checkfileToUpload()) {
            //$("#rp_Item1").find("li.current").attr("id")

            var fd = new FormData();
            fd.append("bianma_liushui",bianma_liushui);
            //fd.append("bianma_liushui",$("#item22").find("li.current").attr("id"));
//            fd.append("xmmc_sc", $("#xmmc_sc").val());
//            fd.append("xmzrr_sc", $("#xmzrr_sc").val());
//            fd.append("cjbm_sc", $("#cjbm_sc").val());
//            fd.append("kcmc_sc", $("#kcmc_sc").val());
            fd.append("xmmc_sc", xmmc_sc);
               fd.append("xmzrr_sc", xmzrr_sc);
               fd.append("cjbm_sc", cjbm_sc);
               fd.append("kcmc_sc", kcmc_sc);
            fd.append("jneirong_sc",filename22);
//            fd.append("jneirong_sc", $("#jneirong_sc").val());
//            fd.append("lkjs_sc", $("#lkjs_sc").val());
            //            fd.append("phone_sc", $("#phone_sc").val());
            fd.append("lkjs_sc", lkjs_sc);
            fd.append("phone_sc", phone_sc);
            fd.append("editor_sc", $("#editor_sc").val());
//            fd.append("beizhu_sc", $("#beizhu_sc").val());
            //var filename = file.name;
            var ext_sc = filename.substring(filename.lastIndexOf(".") + 1, filename.length);
            fd.append("extend_sc", ext_sc);
            fd.append("fileToUpload", document.getElementById('fileToUpload').files[0]);
            var xhr = new XMLHttpRequest();
            xhr.upload.addEventListener("progress", uploadProgress, false);
            xhr.addEventListener("load", uploadComplete, false);
            xhr.addEventListener("error", uploadFailed, false);
            xhr.addEventListener("abort", uploadCanceled, false);
            xhr.open("POST", "yy_ajax/gl_upload.ashx"); //修改成自己的接口
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
        window.parent.location.reload();
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
            //var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,5}$/
           
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
    function checkJneirong2() {
        var filename2 = fileSelected();
        filename22 = filename2.substring(0,filename.lastIndexOf("."));
        if (filename22.length == 0) {
            //$("#lkjs").next("span").css("color", "red").text("不能为空"); 
            alert("讲内容不能为空");
            return false;
            //return true;
        }
        else {
          //var reg = /^\d{3}$|^[\u4E00-\u9FA5\uF900-\uFA2D]{2,30}$/;  //ok
           // var reg = /^\d{3}$|^[\u4e00-\u9fa5]{2,30}$/; //ok
            var reg = /^[0-9a-zA-Z\u4e00-\u9fa5]{2,30}$/;
            if (!reg.test(filename22)) {
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
<script type="text/javascript">
        //显示页面加载时间
        var beforeload = (new Date()).getTime();
        function getPageLoadTime() {
            var afterload = (new Date()).getTime();
            seconds = (afterload - beforeload) / 1000;
            //将结果放到div中
            $("#load_time").text('页面加载时间为：' + seconds + '秒');
        }
        window.onload = getPageLoadTime;
</script>
</head>   

<body>
<div data-role="page" id="yy_main" data-theme="a">
     <div data-role="header" data-position="fixed" > 
        <h1>资源录制管理界面</h1>
     </div>
     <div data-role="content">
      
        <p>请点击相应按钮，可以选择预约录制、预约后期制作、查询录音文件并下载、查询录音和后期预约情况、查询工作进度</p>
        <div class="ui-grid-a">
            <div class="ui-block-a">
                <a href="#gl_upload" target=_blank data-role="button" data-corners="true" data-icon="arrow-u" data-iconpos="top">录制上传</a>                
            </div>
            <div class="ui-block-b">
                <a href="#gl_yy_hq" data-role="button" data-corners="true" data-icon="arrow-r" data-iconpos="top">查看预约后期</a>                
            </div>
             <div class="ui-block-a">
                <a href="#gl_chaxun_download" data-role="button" data-corners="true" data-icon="arrow-d" data-iconpos="top">录音下载</a>                
            </div>
            
                        
        </div>
     </div>
     
     <div data-role="footer" id="Div1" data-position="fixed" >          
        <h4><a href="#">资源制作部@安徽电大</a></h4>
        <h4><div id="load_time"></div></h4>
     </div> 
</div>

<div data-role="page" id="gl_upload">

            <div data-role="header" data-position="fixed" >               
                <h1>资源录制音频上传</h1>               
            </div>
            
            <div data-role="content">
              <p>选择音频文件后点击上传按钮</p>
              <p>如有问题，请联系资源制作部（0551-63634643）。</p> 
             <br/>          
    
            <div class="">
                 <ul >             
                     <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource7">
	                     <ItemTemplate>                   
                            <li ><%# Eval("date")%>   <%# Eval("week")%>   <%# Eval("sjd")%>  <%# Eval("xmmc")%>  <%# Eval("lkjs")%>   <%#(Eval("beizhu").ToString()!="")?"<font color='red'>*</font>":""%>  <%#(Eval("upload").ToString() != "已上传音频") ? "<br/><input type='file' name='fileToUpload' id='fileToUpload' onchange='fileSelected()' autofocus='autofocus'></input><div id='fileName'></div><div id='fileSize'></div><div id='fileType'></div><br/><span>录制人员</span><select id='editor_sc'><option>周锐</option><option>陈冬梅</option><option>朱悦</option><option>方圆</option><option>韩坤</option><option>赵玲</option></select><input type='button' onclick='uploadFile(\"" + Eval("bianma_liushui").ToString() + "\",\"" + Eval("xmmc").ToString() + "\",\"" + Eval("xmzrr").ToString() + "\",\"" + Eval("cjbm").ToString() + "\",\"" + Eval("kcmc").ToString() + "\",\"" + Eval("lkjs").ToString() + "\",\"" + Eval("phone").ToString() + "\")' value='Upload' id='Submit1'/><div id='progressNumber'></div>" : "已上传音频"%> </li>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
            </div>
            
             <span id="nowdate"></span>
             <asp:Label ID="Label3" runat="server" Text="当前日期" hidden="hidden" style="display:none;visibility:hidden"></asp:Label>        
                                
            <a href="#yy_main" data-role="button">返回首页面</a>
            
            <div data-role="footer" id="navbar" data-position="fixed" >          
                  <h4><a href="#yy_beizhu">资源制作部@安徽电大</a></h4>
            </div>  
    
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>"  
                    
                        SelectCommand="SELECT [xmmc], [xmzrr], [cjbm], [date], [week], [sjd], [kcmc], [lkjs], [jneirong], [upload], [beizhu], [phone], [bianma_liushui] FROM [lkzxyy] WHERE ([date] = @date)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label3" Name="date" PropertyName="Text" 
                        Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>              
                            
</div> 
</div>

<div data-role="page" id="gl_upload2">

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

<div data-role="page" id="gl_yy_hq" data-add-back-btn="true">

    <div data-role="header" data-position="fixed">
        <h1>查看后期编辑预约</h1>
    </div>
    
    <div data-role="content">
          <p>预约后请尽快联系所安排的录课教师</p>
           请其带好声音、幻灯转成的mp4等素材至我处剪辑<br />
            <a href="#yy_main">返回首页面</a><br/>
            
          <span>登入时间</span>   <asp:Label ID="date_hq" runat="server" Text="Label"></asp:Label><br />
            
            
           <p>请输入后期制作人员姓名查询</p>
            <span></span>  
            <form action="">
            <input type="text" id="name_editor_hq" name="name_editor" placeholder="请输入" autocomplete="on" autofocus="autofocus"/>        
            <button type="button" id="button_gl_chaxun_hq" value="">查看预约后期 »</button> 
            </form>          
                   
            
          <span></span> 
          <span id="hqbjry2" hidden="hidden" ></span>
                
           <div class="">
                 <ul id="items_gl_hq">             
                     <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
	                     <ItemTemplate>                   
                            <li class="" ></li>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
            </div> 
             <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
              ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>"               
              
              SelectCommand="SELECT [bianma_liushui], [jneirong], [kcmc], [lkjs], [phone], [file1], [editor2], [steps], [completed] FROM [lsxxb]">
          </asp:SqlDataSource>    
                
                  
    </div>
    
    <a href="#yy_main" data-role="button">返回首页面</a>
    
    <div data-role="footer" data-position="fixed">
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
    </div>              

</div> 

<div data-role="page" id="gl_chaxun_download" data-theme="a" data-add-back-btn="true">
     <div data-role="header" data-position="fixed" > 
        <h1>查询录音并下载</h1>
     </div>
     <div data-role="content">
        
        <p>请输入制作人员姓名查询</p>
        <span></span>  
        <form action="">
        <input type="text" id="name_editor_chaxun" name="name_editor" placeholder="请输入" autocomplete="on" autofocus="autofocus"/>        
        <button type="submit" id="button_chaxun" value="">查询录音并下载 »</button> 
        </form>
        <%--<form>
        <input type="text" id="autoOne" name="autoOne" autocomplete="on" />
        <button type="submit" value="提交记忆" />
        </form>--%>
        <br />      
        <span>请点击文件名下载</span>  
        <br />      
        <div class="">
                 <ul id="items_gl_chaxun">             
                     <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
	                     <ItemTemplate >                   
                            <li class="" id=""></li><span></span>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
         </div> 
     </div>
      <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
              ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>" 
              
         
         SelectCommand="SELECT [bianma_liushui], [jneirong], [kcmc], [lkjs], [phone], [file1] FROM [lsxxb]"></asp:SqlDataSource>    
                
     <a href="#yy_main" data-role="button">返回首页面</a>
     
     <div data-role="footer" id="Div3" data-position="fixed" >          
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
     </div> 
</div>

<div data-role="page" id="yy_chaxun_gzjdd" data-theme="a" data-add-back-btn="true">
     <div data-role="header" data-position="fixed" > 
        <h1>查询工作进度</h1>
     </div>
     <div data-role="content">
      
        <p>请输入联系电话查询</p>
        <span></span>  
        <form>
        <input type="text" id="phone_chaxun_gzjdd" name="phone_lkjs" placeholder="请输入" autocomplete="on" autofocus="autofocus"/>
        
        <button type="button" id="button_chaxun_gzjdd" value="">查询工作进度 »</button>       
       
        </form>    
         
        <span>查询结果如下</span>        
        <div class="">
                 <ul id="items_gzjdd">             
                     <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource5">
	                     <ItemTemplate >                   
                            <li class="" id="yy_gzjdd"></li><span></span>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
         </div> 
     </div>
      <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
              ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>"               
         SelectCommand="SELECT [lkjs], [jneirong], [phone], [steps], [completed] FROM [lsxxb]"></asp:SqlDataSource>    
                
     
     <div data-role="footer" id="Div6" data-position="fixed" >          
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
     </div> 
</div>

<div data-role="page" id="yy_chaxun_yy" data-theme="a" data-add-back-btn="true">
     <div data-role="header" data-position="fixed" > 
        <h1>查询录音预约和后期预约</h1>
     </div>
     <div data-role="content">
      
        <p>请输入联系电话查询</p>
        <span></span>  
        <form>
        <input type="text" id="phone_chaxun_yy" name="phone_lkjs" placeholder="请输入" autocomplete="on" autofocus="autofocus"/>
        
        <button type="button" id="button_chaxun_ly" value="">查询录音预约 »</button>
        
        <button type="button" id="button_chaxun_hq" value="">查询后期预约 »</button> 
        </form>    
         
        <span>查询结果如下</span>        
        <div class="">
                 <ul id="items5">             
                     <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource4">
	                     <ItemTemplate >                   
                            <li class="" id="yy_ly"></li><span></span>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
         </div> 
     </div>
      <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
              ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>" 
              
         
         
         SelectCommand="SELECT [lkjs], [date], [week], [sjd], [phone] FROM [lkzxyy]"></asp:SqlDataSource>    
                
     
     <div data-role="footer" id="Div4" data-position="fixed" >          
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
     </div> 
</div>

<div data-role="page" id="yy_chaxun_gzjdd222" data-theme="e">
     <div data-role="header" data-position="fixed" > 
        <h1>查询工作进度</h1>
     </div>
     <div data-role="content">
      
        <p>正在制作中。。敬请期待。。</p>
       
     </div>
     
     <div data-role="footer" id="Div5" data-position="fixed" >          
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
     </div> 
</div>

<div data-role="page" id="yy_hq_gzjdb" data-add-back-btn="true">

    <div data-role="header" data-position="fixed">
        <h1>后期编辑工作进度表_未完成尚在开发中。。</h1>
    </div>
    
    <div data-role="content">
          <p>请输入流水编号,完善课程名称、讲内容等信息</p>
           请带好声音、幻灯转成的mp4等素材来办公室剪辑<br />
            <a href="#yy">转到第1页</a>
            
          <br />  
          <span>流水编号</span>  
          <input type="number" id="number_hq_liushui" placeholder="请输入流水编号"/>
          <button type="button" id="button_hq_chaxun" value="">工作进度查询 »</button>  
            
          <span>课程名称</span>  
          <input type="text" id="kcmc3" placeholder="请输入" />
          
          <span>录课教师</span>  
          <input type="text" id="lkjs3" />          
         
          <span>讲内容</span>  
          <input type="number" id="neirong3" placeholder="请输入"/>
          
          <span>进度1</span>  
          <input type="text" id="jindu1" placeholder="请输入" />
          
          <span>进度2</span>  
          <input type="text" id="jindu2" placeholder="请输入"/>          
         
          <span>进度3</span>  
          <input type="number" id="jindu3" placeholder="请输入"/>
          
          <span>备注</span>  
          <input type="number" id="beizhu3" placeholder="请输入"/>
          
          <button type="button" id="button_hq_xiugai" value="">课程信息完善 »</button>
        
                  
    </div>
    
    <div data-role="footer" data-position="fixed">
        <h4>管理入口</h4>
    </div>              

</div>   
 
</body>
</html>
