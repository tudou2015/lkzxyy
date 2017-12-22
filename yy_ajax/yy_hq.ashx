<%@ WebHandler Language="C#" Class="Website.Ajax_hq.login" %>

using System; 
using System.Collections; 
using System.Data; 
using System.Linq; 
using System.Web; 
using System.Web.Services; 
using System.Web.Services.Protocols; 
using System.Xml.Linq; 
using System.Data.SqlClient; 
using System.Web.SessionState; //支持session必须的引用 
using System.Configuration;
//using Microsoft.ApplicationBlocks.Data;
using System.Text.RegularExpressions;
using yanzheng_tools;

namespace Website.Ajax_hq 
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class login : IHttpHandler, IRequiresSessionState
    {
       [WebMethod(EnableSession = true)]
        public void ProcessRequest(HttpContext context)
        {      
            context.Response.ContentType = "html"; //解决360极速浏览器chrome内核不兼容问题       
           //接收到的数据
       // string username_c = context.Request.Form["username"];
            string date_c = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
           string lkjs_c=context.Request.Form["lkjs_hq"];            
           string number_c=context.Request.Form["number_hq"];    
           string phone_c=context.Request.Form["phone_hq"];
           string beizhu_c=context.Request.Form["beizhu_hq"];
        //string password_c = context.Request.Form["password"];   
        //string xingmin_c =context.Request.Form["xingmin"];
       // string sfzh_c = context.Request.Form["sfzh"];
        //string qq_c = context.Request.Form["qq"];
        //string email_c = context.Request.Form["email"];
        //string phone_c = context.Request.Form["phone"];
         //检查输入的规范性，第1层防护
        if (!(checkDate(date_c)))
        {
            ///不规范的做记录
            //writeinto_hacklog();
            context.Response.Write("2");//不符合数据库规范，已被记录       
        }
        else
        {
            if (checkDateSjd_exist(date_c))
            {
                context.Response.Write("3");  //时间段已被占用
            }
            else
            {
                ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
                //string username_k = yanzheng.Filter(username_c);
                string date_k = yanzheng.Filter(date_c);      
                string lkjs_k = yanzheng.Filter(lkjs_c);
                string number_k = yanzheng.Filter(number_c);        
                string phone_k = yanzheng.Filter(phone_c);
                string beizhu_k = yanzheng.Filter(beizhu_c);
                //string password_k = yanzheng.Filter(password_c);
               // string xingmin_k = yanzheng.Filter(xingmin_c);
               // string sfzh_k = yanzheng.Filter(sfzh_c);
               // string qq_k = yanzheng.Filter(qq_c);
                //string email_k = yanzheng.Filter(email_c);
               // string phone_k = yanzheng.Filter(phone_c);
               // string xingmin_zhuanma = HttpUtility.UrlDecode(xingmin_k);

                //string[] Day = new string[] { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
                //DateTime dt_c = Convert.ToDateTime(date_k);
                //DateTime dt_k = new DateTime(dt_c);
                //string week_c = dt_k.DayOfWeek.ToString("d");
                //string week_k = Day[Convert.ToInt32(week_c)].ToString();
                //string week_k=CaculateWeekDay(date_k);

                Random sjm = new Random();
                double suijima = sjm.NextDouble();
                Int32 suijima_four = (Int32)(suijima * 10000);
                string suijima_weiyi = suijima_four.ToString("d4");
                string TimeFormat = "yyyyMMddHHmmss";
                string bianma_time = DateTime.Now.ToString(TimeFormat);
                string bianma_yy = bianma_time.Trim() + suijima_weiyi.Trim()+"2";
                
                //string liushui_weiyi="";
                //string TimeFormat2="yyMMdd";
                //string liushui_time=DateTime.Now.ToString(TimeFormat2);
                //string liushui_yy=liushui_time.Trim()+liushui_weiyi     

                string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                string sql = "insert into hqbjyy(bianma,date,lkjs,number,phone,beizhu) values(@bm1,@date1,@lkjs1,@number1,@phone1,@beizhu1)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                ///参数化查询解决非法字符问题，并限制长度，第3层防护
                SqlParameter pbianma_yy = cmd.Parameters.Add("@bm1", SqlDbType.VarChar, 19);
                /*SqlParameter pshijian = cmd.Parameters.Add("@shijian1", SqlDbType.VarChar, 20);
                SqlParameter pusername = cmd.Parameters.Add("@username1", SqlDbType.VarChar,20);
                SqlParameter ppassword = cmd.Parameters.Add("@password1", SqlDbType.VarChar,15);
                SqlParameter pxingmin = cmd.Parameters.Add("@xingmin1", SqlDbType.VarChar,10);
                SqlParameter psfzh = cmd.Parameters.Add("@sfzh1", SqlDbType.VarChar,18);
                SqlParameter pqq = cmd.Parameters.Add("@qq1", SqlDbType.VarChar,15);
                SqlParameter pemail = cmd.Parameters.Add("@email1", SqlDbType.VarChar,30);
                SqlParameter pphone = cmd.Parameters.Add("@phone1", SqlDbType.VarChar,11);
                SqlParameter pip = cmd.Parameters.Add("@ip1", SqlDbType.VarChar, 15);
                SqlParameter phostname = cmd.Parameters.Add("@hostname1", SqlDbType.VarChar, 20);
                SqlParameter pliulanqi = cmd.Parameters.Add("@liulanqi1", SqlDbType.VarChar, 150);*/
                SqlParameter pdate=cmd.Parameters.Add("@date1",SqlDbType.VarChar,20); 
                SqlParameter plkjs=cmd.Parameters.Add("@lkjs1",SqlDbType.VarChar,30);
                SqlParameter pnumber = cmd.Parameters.Add("@number1",SqlDbType.VarChar,30);
                SqlParameter pphone = cmd.Parameters.Add("@phone1",SqlDbType.VarChar,13);
                SqlParameter pbeizhu = cmd.Parameters.Add("@beizhu1",SqlDbType.VarChar,50);

                pbianma_yy.Value = bianma_yy;
                pdate.Value = date_k;
                plkjs.Value = lkjs_k;
                pnumber.Value = number_k;
                pphone.Value = phone_k;
                pbeizhu.Value = beizhu_k;
                /*pshijian.Value = DateTime.Now.ToString();
                pusername.Value = username_k;
                ppassword.Value = password_k;
                pxingmin.Value = xingmin_zhuanma;
                psfzh.Value = sfzh_k;
                pqq.Value = qq_k;
                pemail.Value = email_k;
                pphone.Value = phone_k;
                pip.Value = context.Request.UserHostAddress.ToString();
                phostname.Value = context.Request.UserHostName.ToString();
                pliulanqi.Value = context.Request.UserAgent.ToString();*/

                // SqlCommand cmd = new SqlCommand(sql,new SqlHelper().sql(conn));
                conn.Open();             
                int count = cmd.ExecuteNonQuery();
                conn.Close();
                if (count > 0)
                { 
                    //context.Response.Write("1");//预约成功
                    //分配后期制作人员
                    //AssignedWork(); 
                    //string sql_min = "select editor,beforenum from editors where flag='true' order by beforenum";
                    string sql_min = "select editor,beforenum from editors where flag='true' order by nownum";
                    SqlCommand cmd_min = new SqlCommand(sql_min, conn);
                    conn.Open();
                    string cc = cmd_min.ExecuteScalar().ToString();
                    conn.Close();

                    //更新hqbjyy表
                    //string sql_hq = "update hqbjyy set editor=@cc where bianma=@bianma_yy;select flag2,nownum from editors;";
                    string sql_hq = "update hqbjyy set editor=@cc1 where bianma=@bianma_yy1";
                    SqlCommand cmd_hq = new SqlCommand(sql_hq, conn);
                    SqlParameter pcc = cmd_hq.Parameters.Add("@cc1", SqlDbType.VarChar, 12);
                    SqlParameter pbianma_hq = cmd_hq.Parameters.Add("@bianma_yy1", SqlDbType.VarChar, 19);
                    pcc.Value = cc;
                    pbianma_hq.Value = bianma_yy;
                    conn.Open();
                    cmd_hq.ExecuteNonQuery();
                    conn.Close();

                    //更新editors表
                    string sql_editor = "update editors set flag2=flag2+1,beforenum=nownum,added=@added2,nownum=nownum+@added2 where editor=@editor2";
                    SqlCommand cmd_editor = new SqlCommand(sql_editor, conn);
                    SqlParameter pnownum = cmd_editor.Parameters.Add("@added2", SqlDbType.Int);
                    SqlParameter peditor = cmd_editor.Parameters.Add("@editor2",SqlDbType.VarChar,12);
                    pnownum.Value = Convert.ToInt32(number_k);
                    peditor.Value = cc;
                    conn.Open();
                    cmd_editor.ExecuteNonQuery();
                    conn.Close();

                    string cc2 = "1" + "##" + cc+"##"+bianma_yy;
                    context.Response.Write(cc2);
                    //HttpContext.Current.Session["hqbjry"] = cc;
                    //context.Session["hqbjry"] = cc;
                    //Session["hqbjry"] = cc;
                    //context.Session["hqbjry"] = cc;
                    //hqbjry3.text = cc;
                    //context.Response.Write("1");
                    //hqbjry.text = cc;
                    //context.Response.Write("{'success':'1','hqbjry':@cc}");//预约成功
                       
                    //if (AssignedWork() != null) {
                    //    //更新hqbjyy表
                    //    //string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
                    //    //SqlConnection conn = new SqlConnection(connStr);
                    //    //string sql = "select editor,sum (number) from hqbjyy group by editor";
                    //    //string sql = "select editor,sum (number) as num from hqbjyy group by editor order by num";
                    //    string sql_hq = "update set editor=@cc where bianma=@bianma_yy";
                    //    SqlCommand cmd_min = new SqlCommand(sql_min, conn);
                    //    SqlParameter pcc = cmd.Parameters.Add("@cc", SqlDbType.VarChar, 12);
                    //    SqlParameter pbianma = cmd.Parameters.Add("@bianma_yy", SqlDbType.VarChar, 19);

                    //    pcc.Value = cc;
                    //    pbianma_yy.Value = bianma_yy;
                        
                    //    //SqlCommand cmd_hq = new SqlCommand(sql_hq, conn);
                    //    //conn.Open();
                    //    //cmd_hq.ExecuteNonQuery();
                    //    //conn.Close();
                    //    //更新editors表
                    //    string sql_editor = "update set flag2=+1 beforenum=nownum nownum=+number_k  where editor=cc";
                    //    SqlCommand cmd_editor = new SqlCommand(sql_editor, conn);
                    //    conn.Open();
                    //    cmd_hq.ExecuteNonQuery();
                    //    conn.Close();
                                            
                    //}               
                }
                else
                {
                    context.Response.Write("0");//预约失败
                }  
            }           
            context.Response.End();//必不可少，不然360极速浏览器会出错   
        }  
       }      
        
        //AssignedWork()
        public static string AssignedWork(){
            //select editor，sum（number） from hqbjyy group by editor;
             string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
           SqlConnection conn = new SqlConnection(connStr);
           //string sql = "select editor,sum (number) from hqbjyy group by editor";
           //string sql = "select editor,sum (number) as num from hqbjyy group by editor order by num";
           string sql = "select editor,beforenum from editors where flag='true' order by beforenum";
           SqlCommand cmd = new SqlCommand(sql, conn);
           ///参数化查询解决非法字符问题，并限制长度，第3层防护
           //SqlParameter pusername = cmd.Parameters.Add("@username2", SqlDbType.VarChar, 18);
           //SqlParameter pdate = cmd.Parameters.Add("@date2", SqlDbType.VarChar, 30);
           //SqlParameter psjd = cmd.Parameters.Add("@sjd2", SqlDbType.VarChar, 30); 
           //SqlParameter peditor = cmd.Parameters.Add("@editor2",SqlDbType.VarChar,30);       

           //pusername.Value = username_k;
           //pdate.Value = date_k;
           //psjd.Value = sjd_k; 
            //peditor=
          
           conn.Open();
           //SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
           //SqlDataReader sdr = cmd.ExecuteScalar(CommandBehavior.CloseConnection);
           //SqlDataReader sdr = cmd.ExecuteNonQuery();
           //DataSet ds = new DataSet();
           //bool dd=sdr.HasRows;
           //object re3 = cmd.ExecuteNonQuery();
           //object res = cmd.ExecuteReader(CommandBehavior.CloseConnection);
           //object res2 = cmd.ExecuteScalar();
           string cc = cmd.ExecuteScalar().ToString();
            
           //conn.Close();         
           //if (sdr.Read())
           // if(cc==null)
           //{
           ////    //return true;//时间段已被占用
           ////    string cc = sdr[0].ToString();
           //    //string sql2 = "update set editor= where ";
           //    //SqlCommand cmd2 = new SqlCommand(sql, conn);
           //    //cmd2.ExecuteNonQuery();
           //    context.Response.Write("7");//找不到editor               
           //}
           //else
           //{
           ////    //return false;//时间段空闲可以使用
           //     //更新hqbjyy表
                
           //     //更新editors表
                
               
           //}
           //////sdr.Close();      
           conn.Close();
           return cc;
                
        }
        
        //查询时间段是否已占用
       public static bool checkDateSjd_exist(string date_e)
       {
           /////过滤非法字符，';--等，防止欺骗性规范，第2层防护
           ////string username_k = yanzheng.Filter(username_e); 
           //string date_k = yanzheng.Filter(date_e);
           //string sjd_k = yanzheng.Filter(sjd_e);         

           //string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
           //SqlConnection conn = new SqlConnection(connStr);
           //string sql = "select lkjs,date,sjd from lkzxyy where date=@date2 and sjd=@sjd2";
           //SqlCommand cmd = new SqlCommand(sql, conn);
           /////参数化查询解决非法字符问题，并限制长度，第3层防护
           ////SqlParameter pusername = cmd.Parameters.Add("@username2", SqlDbType.VarChar, 18);
           //SqlParameter pdate = cmd.Parameters.Add("@date2", SqlDbType.VarChar, 30);
           //SqlParameter psjd = cmd.Parameters.Add("@sjd2", SqlDbType.VarChar, 30);        

           ////pusername.Value = username_k;
           //pdate.Value = date_k;
           //psjd.Value = sjd_k; 
          
           //conn.Open();
           //SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
           ////conn.Close();         
           //if (sdr.Read())
           //{
           //    return true;//时间段已被占用
               
           //}
           //else
           //{
           //    return false;//时间段空闲可以使用
           //}
           ////sdr.Close();      
           //conn.Close();
           return false;
       }
        
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        // check date
        public static bool checkDate(string date_c)
        {
            //string str = date_c;
            ////string pattern = @"^(d{4})-(d{2})-(d{2})$";   //匹配/和hp之间的字符
            //string pattern = @"^\d{4}-\d{2}-\d{2}$"; 
            //bool exist = Regex.IsMatch(str, pattern);  //验证下是否匹配成功
            //string result = Regex.Match(str, pattern).Value; //匹配到的值          
            //if (!exist)
            //{
            //    return false;
            //}
            //else
            //{
            //    return true;
            //}
            return true;
        }
       
        // check sjd
        public static bool checkSjd(string sjd_c)
        {
            string str = sjd_c;
            //string pattern = @"^(d{1,2}):(d{2}(-|~)(d{1,2})(d{2})$";   //匹配/和hp之间的字符
            string pattern = @"^\d{1,2}:\d{2}~\d{1,2}:\d{2}$";
            bool exist = Regex.IsMatch(str, pattern);  //验证下是否匹配成功
            string result = Regex.Match(str, pattern).Value; //匹配到的值          
            if (!exist)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        //y－年，m－月，d－日期
      //string CaculateWeekDay(int y,int m, int d)
        string CaculateWeekDay(string ss)
        {
              string[] ss_c=ss.Split('-');		
		        int y=Convert.ToInt32(ss_c[0]);
                int m = Convert.ToInt32(ss_c[1]);
                int d = Convert.ToInt32(ss_c[2]);
                if (m == 1) m = 13;
                if (m == 2) m = 14;
                //if (m == 1 || m == 2)
                //{
                //    m += 12;
                //    y--;
                //}
               int week=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7; 
              string weekstr="";
              switch(week)
               {
                    
                    case 0: weekstr="星期一"; break;
                    case 1: weekstr="星期二"; break;
                    case 2: weekstr="星期三"; break;
                    case 3: weekstr="星期四"; break;
                    case 4: weekstr="星期五"; break;
                    case 5: weekstr="星期六"; break;
                    case 6: weekstr = "星期日"; break;
                    
               }
              return weekstr; 
         }





    
    }

}