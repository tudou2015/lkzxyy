<%@ page language="C#" autoeventwireup="true" inherits="_Default, App_Web_2pnafli9" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, width=device-width,user-scalable=no" />
    <title>资源录制在线预约</title> 
<link href="yy_css/jquery.mobile-1.4.5.css" rel="Stylesheet" type="text/css" />
<link href="yy_css/drag.css" rel="Stylesheet" type="text/css" />
<script src="yy_js/jquery-2.2.4.js" type="text/javascript"></script>
<script src="yy_js/jquery.mobile-1.4.5.js" type="text/javascript"></script>
<script src="yy_js/yy.js" type="text/javascript"></script>
<script src="yy_js/yy_hq.js" type="text/javascript"></script>
<script src="yy_js/yy_chaxun.js" type="text/javascript"></script>

<script src="yy_js/yy_chaxun_gzjdd.js" type="text/javascript"></script>
<script src="yy_js/jrender.js" type="text/javascript"></script>
<script src="My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="yy_js/drag.js" type="text/javascript"></script>
<script src="yy_js/json2.js" type="text/javascript"></script>
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
    //显示页面加载时间
    var beforeload=(new Date()).getTime();
    function getPageLoadTime(){    
        var afterload = (new Date()).getTime();
        seconds = (afterload - beforeload) / 1000;
        //将结果放到div中
        $("#load_time").text('页面加载时间为：' + seconds + '秒');
    }
    window.onload = getPageLoadTime;
</script>
<script type="text/javascript">
    $(document).bind("pageinit", function() {
        $.mobile.page.prototype.options.backBtnText = "返回";
        $.mobile.page.prototype.options.addBackBtn = true;
    });
</script>
<style type="text/css">
.chk_1 { 
    display: none; 
} 
 
.chk_1 + label { 
    background-color: #FFF; 
    border: 1px solid #C1CACA; 
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05); 
    padding: 9px; 
    border-radius: 5px; 
    display: inline-block; 
    position: relative; 
    margin-right: 30px; 
} 
.chk_1 + label:active { 
    box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1); 
} 
 
.chk_1:checked + label { 
    background-color: #ECF2F7; 
    border: 1px solid #92A1AC; 
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1); 
    color: #243441; 
} 
 
.chk_1:checked + label:after { 
    content: '\2714'; 
    position: absolute; 
    top: 0px; 
    left: 0px; 
    color: #758794; 
    width: 100%; 
    text-align: center; 
    font-size: 1.4em; 
    padding: 1px 0 0 0; 
    vertical-align: text-top; 
} 
</style>
<!--[if lte IE 8]> 
<link href="ie8.css" rel="stylesheet" /> 
<![endif]-->  
</head>   

<body>
<div data-role="page" id="yy_main" data-theme="a" data-add-back-btn="true" >
     <div data-role="header" data-position="fixed" > 
        <h1>资源录制</h1>
     </div>
     <div data-role="content">
      
        <p>请点击相应按钮，可以选择预约录制、预约后期制作、查询录音文件并下载、查询录音和后期预约情况、查询工作进度</p>
        <div class="ui-grid-a">
            <div class="ui-block-a">
                <a href="#yy" data-role="button" data-corners="true" data-icon="arrow-l" data-iconpos="top">预约录制</a>                
            </div>
             <div class="ui-block-b">
                <a href="#yy_chaxun_gzjdd" data-role="button" data-corners="true" data-icon="search" data-iconpos="top">查询工作进度</a>                
            </div>  
           
             <div class="ui-block-a">
                <a href="#yy_chaxun" data-role="button" data-corners="true" data-icon="arrow-d" data-iconpos="top">录音下载</a>                
            </div>
            
            <div class="ui-block-b">
                <a href="#yy_chaxun_yy" data-role="button" data-corners="true" data-icon="search" data-iconpos="top">查询预约情况</a>                
            </div>
            
        </div>
     </div>
     
           
     <div data-role="footer" id="Div1" data-position="fixed" >          
        <h4><a href="#">资源制作部@安徽电大</a></h4>
        <h4><div id="load_time"></div></h4>
     </div> 
</div>

<div data-role="page" id="yy" data-add-back-btn="true" > 

            <div data-role="header" data-position="fixed" >               
                <h1>资源录制在线预约</h1>               
            </div>
            
            <div data-role="content">
              <p>请录课老师认真估算所需时间，按需预约，在所约时间段未能完成的，请使用您的下一个预约时间段。</p>
              <p>如有问题，请联系资源制作部（0551-63634643）。</p> 
              
            <form autocomplete="on" >
                <span>项目名称</span>              
                <select id="xmmc" autofocus="autofocus">  
                <option>成教(皖西学院)</option>  
                <option>成教(华中科大)</option>              
                </select>    
                                
                <span>项目责任人</span>  
                <input type="text" id="xmzrr" name="name_xmzrr" placeholder="请输入" />
               
                <span>承建部门</span> 
                <select id="cjbm"> 
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
               
                <span>预约日期（有效预约日期4天以上,10天以内）</span> 
                <input id="date" placeholder="YYYY-MM-DD" type="text" onclick="WdatePicker({readOnly:true,minDate:'%y-%M-{%d+4}',maxDate:'%y-%M-{%d+9}',disabledDays:[0,6],disabledDates:['2017-05-01','2017-05-10','2017-05-31']})" />            
              
                <span>时间段选择</span>     
                <select id="sjd">  
                    <option>09:00~09:30</option>  
                    <option>09:30~10:00</option>
                    <option>10:00~10:30</option>
                    <option>10:30~11:00</option>
                    <option>15:00~15:30</option>
                    <option>15:30~16:00</option>
                    <option>16:00~16:30</option>
                    <option>16:30~17:00</option>               
                </select> 
                
                <span>课程名称</span>  
                <input type="text" id="kcmc" name="name_kcmc" placeholder="请输入"/>
                               
                <span>录课教师</span>  
                <input type="text" list="lkr" id="lkjs" name="name_lkjs" placeholder="请输入" />                               
               
                <span>联系电话</span>  
                <input type="text" id="phone" name="phone_lkjs" placeholder="请输入" /><span></span>            
               
                <span>备注（如有特殊需要，请备注）</span>  
                <input type="text" id="beizhu"><span></span>
                <span>验证码</span>
                
                <div id="drag"></div>
                    <script type="text/javascript">
                        $("#drag").drag();
                    </script> 
                
                <span id="nowdate"></span>
                <asp:Label ID="Label1" runat="server" Text="当前日期" hidden="hidden" style="display:none;visibility:hidden"></asp:Label>
                <span id="yzcg"></span> 
                <asp:Label ID="Label2" runat="server" Text="待验证" hidden="hidden"></asp:Label>                          
         
                <button type="submit" id="button_yy" value="" >预约 »</button> 
             </form>    
                
              <p>注：1、预约后我们尽快安排；</p>
              <p>    2、后期编辑前请将幻灯转成mp4；</p> 
              <p>    3、如需查询可到查询预约情况页面查询录制和后期预约情况。</p>               
            </div>           
    
            <div class="">
                 <ul>             
                     <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
	                     <ItemTemplate>                   
                            <li class="" ><%# Eval("date")%>   <%# Eval("week")%>   <%# Eval("sjd")%>   <%# Eval("lkjs")%>   <%#(Eval("beizhu").ToString()!="")?"<font color='red'>*</font>":""%>  </li>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
            </div>
            
            <a href="#yy_main" data-role="button">返回首页面</a>
            
            <div data-role="footer" id="navbar" data-position="fixed" >          
                  <h4><a href="#yy_beizhu">资源制作部@安徽电大</a></h4>
            </div>  
    
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>"                 
                
                SelectCommand="SELECT [id], [date], [sjd], [lkjs], [beizhu], [week], [xmmc], [xmzrr], [cjbm], [phone], [bianma_liushui] FROM [lkzxyy] WHERE ([date] &gt;= @date2) ORDER BY [date], [sjd]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label1" Name="date2" PropertyName="Text" 
                        Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>              
                            
</div> 

<div data-role="page" id="yy_beizhu" data-add-back-btn="true">

    <div data-role="header" data-position="fixed">
        <h1>录制预约带备注</h1>
    </div>
    
    <div data-role="content">
    
    
          <p>注意录制预约备注</p>
           <br />
            <a href="#yy_main">返回首页面</a><br/>            
            
            <div class="">
                 <ul>             
                     <asp:Repeater ID="Repeater7" runat="server" DataSourceID="SqlDataSource1">
	                     <ItemTemplate>                   
                            <li class="" ><%# Eval("date")%>   <%# Eval("week")%>   <%# Eval("sjd")%>   <%# Eval("lkjs")%>   <%# Eval("beizhu")%></li>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
            </div>        
    </div> 
    
    <a href="#yy_main" data-role="button">返回首页面</a>
    
    <div data-role="footer" data-position="fixed">
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
    </div> 
                

</div> 

<div data-role="page" id="yy_hq" data-add-back-btn="true">

    <div data-role="header" data-position="fixed">
        <h1>后期编辑预约</h1>
    </div>
    
    <div data-role="content">
          <p>预约后我们将尽快安排人员剪辑</p>
           请带好声音、幻灯转成的mp4等素材至分配人员处剪辑<br />
            <a href="#yy_main">返回首页面</a><br/>
            
          <span>登记时间</span>   <asp:Label ID="date_hq" runat="server" Text="Label"></asp:Label><br />
         
          
          <span>登记教师</span>  
          <form autocomplete="on">
          <input type="text" id="lkjs_hq" name="name_lkjs" placeholder="请输入"  autofocus="autofocus"/>
          
          <span>登记数量</span>
          <div data-tap-disabled="true">
                <select id="number_hq" data-tap-disabled=”true”>  
                    <option value="0">0</option>  
                    <option selected="selected" value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                    <option>8</option>  
                    <option>9</option>
                    <option>10</option>
                    <option>11</option>
                    <option>12</option>
                    <option>13</option>
                    <option>14</option>
                    <option>15</option>
                    <option>16</option>
                    <option>17</option>
                    <option>18</option>
                    <option>19</option>
                    <option>20</option>                   
                </select>
          </div> 
          
          <span>联系电话</span>  
          <input type="text" id="phone_hq" name="phone_lkjs" placeholder="请输入" />
          
          <span>备注（如有特殊需要，请备注）</span>  
                <input type="text" id="beizhu_hq"><span></span>
          
          <button type="submit" id="button_hqyy" value="">预约后期 »</button>   
          </form>       
          <span>我们将安排后期编辑人员<font color='red'><asp:Label ID="hqbjry" runat="server" Text="***"></asp:Label></font>尽快与您联系</span> 
          <span id="hqbjry2" hidden="hidden" ></span>
                
           <div class="">
                 <ul>             
                     <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
	                     <ItemTemplate>                   
                            <li class="" ><%# Eval("date")%>   <%# Eval("lkjs")%>   <%# Eval("number")%>   <%# Eval("phone")%>   <%#(Eval("beizhu").ToString()!="")?"<font color='red'>*</font>":""%>   <%# Eval("editor")%></li>
                         </ItemTemplate>               
                     </asp:Repeater>   
                 </ul>
            </div> 
             <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
              ConnectionString="<%$ ConnectionStrings:yyvodConnectionString %>" 
              SelectCommand="SELECT [date], [lkjs], [number], [phone], [editor], [beizhu] FROM [hqbjyy] ORDER BY [date]"></asp:SqlDataSource>    
                
                  
    </div>
    
    <a href="#yy_main" data-role="button">返回首页面</a>
    
    <div data-role="footer" data-position="fixed">
        <h4><a href="#yy_main">资源制作部@安徽电大</a></h4>
    </div>              

</div> 

<div data-role="page" id="yy_chaxun" data-theme="a" data-add-back-btn="true">
     <div data-role="header" data-position="fixed" > 
        <h1>查询录音并下载</h1>
     </div>
     <div data-role="content">
        
        <p>请输入联系电话查询</p>
        <span></span>  
        <form action="">
        <input type="text" id="phone_chaxun" name="phone_lkjs" placeholder="请输入" autocomplete="on" autofocus="autofocus"/>        
        <button type="submit" id="button_chaxun" value="">查询录音并下载 »</button> 
        </form>
        <%--<form>
        <input type="text" id="autoOne" name="autoOne" autocomplete="on" />
        <button type="submit" value="提交记忆" />
        </form>--%>
              
        <span>请点击文件名下载</span>
        <br/><span>如未预约后期请勾选后点击提交按钮预约后期</span>
        <input type="button" id="button_chaxun_yyhq" data-inline="true" value="提交预约后期"/>        
        <div class="">
                 <ul id="items">             
                     <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
	                     <ItemTemplate >                   
                            <li class="" id="file1_wav"></li><span></span>
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
         SelectCommand="SELECT [bianma_liushui], [jneirong], [lkjs], [jindu], [editor], [step], [completed] FROM [lsjdb]"></asp:SqlDataSource>    
                
     <a href="#yy_main" data-role="button">返回首页面</a>
     
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
                
     <a href="#yy_main" data-role="button">返回首页面</a>
     
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
<script src="yy_js/yy_chaxun_ly.js" type="text/javascript"></script>
</html>
