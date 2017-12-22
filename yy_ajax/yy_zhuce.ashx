<%@ WebHandler Language="C#" Class="Website.Ajax.login" %>

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

namespace Website.Ajax 
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
           string xmmc_c=context.Request.Form["xmmc"];
           string xmzrr_c=context.Request.Form["xmzrr"];
           string cjbm_c=context.Request.Form["cjbm"];
           string date_c=context.Request.Form["date"];
           string sjd_c=context.Request.Form["sjd"];
           string kcmc_c=context.Request.Form["kcmc"];
           string lkjs_c=context.Request.Form["lkjs"];
           string phone_c=context.Request.Form["phone"];
           string beizhu_c=context.Request.Form["beizhu"];      
         //检查输入的规范性，第1层防护
        if (!(checkDate(date_c)&&checkSjd(sjd_c)))
        {
            ///不规范的做记录
            //writeinto_hacklog();
            context.Response.Write("2");//不符合数据库规范，已被记录       
        }
        else
        {
            if (checkDateSjd_exist(date_c,sjd_c))
            {
                context.Response.Write("3");  //时间段已被占用
            }
            else
            {
                ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
                //string username_k = yanzheng.Filter(username_c);
                string xmmc_k = yanzheng.Filter(xmmc_c);
                string xmzrr_k = yanzheng.Filter(xmzrr_c);
                string cjbm_k = yanzheng.Filter(cjbm_c);
                string date_k = yanzheng.Filter(date_c);
                string sjd_k = yanzheng.Filter(sjd_c);
                string kcmc_k = yanzheng.Filter(kcmc_c);
                string lkjs_k = yanzheng.Filter(lkjs_c);
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
                string week_k=CaculateWeekDay(date_k);

                Random sjm = new Random();
                double suijima = sjm.NextDouble();
                Int32 suijima_four = (Int32)(suijima * 10000);
                string suijima_weiyi = suijima_four.ToString("d4");
                string TimeFormat = "yyyyMMddHHmmss";
                string bianma_time = DateTime.Now.ToString(TimeFormat);
                string bianma_yy = bianma_time.Trim() + suijima_weiyi.Trim()+"1";  

                string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                //生成流水号
                //先写入nowdate_short
                string sql_liushui0 = "update configyy set nowdate_short=@nowdate_short0 where flag=1";
                SqlCommand cmd_liushui0 = new SqlCommand(sql_liushui0, conn);
                SqlParameter pnowdate_short0 = cmd_liushui0.Parameters.Add("@nowdate_short0", SqlDbType.VarChar, 6);
                pnowdate_short0.Value = DateTime.Now.ToString("yyyyMMdd").Substring(2);               
                conn.Open();
                cmd_liushui0.ExecuteNonQuery();
                conn.Close();
                
                string sql_liushui = "select beforedate_short,nowdate_short,nowliushui,flag2 from configyy where flag=1";
                SqlCommand cmd_liushui = new SqlCommand(sql_liushui, conn);
                ///参数化查询解决非法字符问题，并限制长度，第3层防护
                conn.Open();
                SqlDataReader sdr = cmd_liushui.ExecuteReader(CommandBehavior.CloseConnection);
                if (sdr.Read())
                {
                    string beforedate_short = sdr[0].ToString();
                    string nowdate_short = sdr[1].ToString();
                    string nowliushui = sdr[2].ToString();
                    int flag2 = Convert.ToInt32(sdr[3]);
                    sdr.Close();
                    if ((flag2 == null)||(flag2 == 0) || (beforedate_short != nowdate_short))
                    {
                        nowliushui = "001";
                        string sql_liushui1 = "update configyy set beforedate_short=nowdate_short,flag2=1,nowliushui='001',beforenum=nownum,added=1,nownum=nownum+1 where flag=1";
                        SqlCommand cmd_liushui1 = new SqlCommand(sql_liushui1, conn);
                        conn.Open();
                        cmd_liushui1.ExecuteNonQuery();
                        conn.Close();
                    }
                    else
                    {
                        //liushui + 1;
                        //update +1
                        //flag2+1
                        string sql_liushui2 = "update configyy set beforedate_short=nowdate_short,nowdate_short=@nowdate_short,flag2=flag2+1,beforeliushui=nowliushui,nowliushui=nowliushui+1,beforenum=nownum,added=1,nownum=nownum+1 where flag=1";
                        SqlCommand cmd_liushui2 = new SqlCommand(sql_liushui2, conn);
                        SqlParameter pnowdate_short = cmd_liushui2.Parameters.Add("@nowdate_short", SqlDbType.VarChar, 6);
                        //pnowdate_short.Value = DateTime.Now.ToString("yyyyMMdd").PadRight(6);
                        //pnowdate_short.Value = DateTime.Now.ToString("yyyyMMdd").Substring(2);
                        pnowdate_short.Value = date_k.Replace("-","").Substring(2);
                        //string ppp = DateTime.Now.ToString("yyyyMMdd").PadRight(6);
                        //string ppp2 = DateTime.Now.ToString("yyyyMMdd").Substring(2);
                        //pnowdate_short.Value = Convert(varchar(6), DateTime.Now, 12);
                        conn.Open();
                        cmd_liushui2.ExecuteNonQuery();
                        conn.Close();
                    }

                }
                else { sdr.Close(); }                
                //sdr.Close();
                conn.Close();
               
                //获取流水号
                string sql_liushui3 = "select nowdate_short,nowliushui from configyy where flag=1";
                string bianma_liushui3 = null;
                SqlCommand cmd_liushui3 = new SqlCommand(sql_liushui3, conn);
                conn.Open();
                SqlDataReader sdr3 = cmd_liushui3.ExecuteReader(CommandBehavior.CloseConnection);
                if (sdr3.Read()) { 
                     string nowdate_short3 = sdr3[0].ToString();                   
                        string nowliushui3 = sdr3[1].ToString();
                        bianma_liushui3 = nowdate_short3 + nowliushui3.PadLeft(3,'0');
                
                }                   
                    //sdr.Close();        
                conn.Close();


                string sql = "insert into lkzxyy(bianma,bianma_liushui,xmmc,xmzrr,cjbm,date,week,sjd,kcmc,lkjs,phone,beizhu) values(@bm1,@bianma_liushui1,@xmmc1,@xmzrr1,@cjbm1,@date1,@week1,@sjd1,@kcmc1,@lkjs1,@phone1,@beizhu1)";
                //insert into gzjdd(bianma,bianma_liushui,xmmc,xmzrr,cjbm,lkjs,phone,beizhu) values(@bm1,@bianma_liushui1,@xmmc1,@xmzrr1,@cjbm1,@lkjs1,@phone1,@beizhu1);
                SqlCommand cmd = new SqlCommand(sql, conn);
                ///参数化查询解决非法字符问题，并限制长度，第3层防护
                SqlParameter pbianma_yy = cmd.Parameters.Add("@bm1", SqlDbType.VarChar, 19);
                SqlParameter pbianma_liushui = cmd.Parameters.Add("@bianma_liushui1",SqlDbType.VarChar,9);              
                SqlParameter pxmmc = cmd.Parameters.Add("@xmmc1",SqlDbType.VarChar,50);
                SqlParameter pxmzrr = cmd.Parameters.Add("@xmzrr1",SqlDbType.VarChar,30);
                SqlParameter pcjbm = cmd.Parameters.Add("@cjbm1",SqlDbType.VarChar,30);
                SqlParameter pdate=cmd.Parameters.Add("@date1",SqlDbType.VarChar,20);
                SqlParameter pweek = cmd.Parameters.Add("@week1",SqlDbType.VarChar,3);
                SqlParameter psjd=cmd.Parameters.Add("@sjd1",SqlDbType.VarChar,30);
                SqlParameter pkcmc = cmd.Parameters.Add("@kcmc1",SqlDbType.VarChar,30);
                SqlParameter plkjs=cmd.Parameters.Add("@lkjs1",SqlDbType.VarChar,30);
                SqlParameter pphone = cmd.Parameters.Add("@phone1",SqlDbType.VarChar,13);
                SqlParameter pbeizhu = cmd.Parameters.Add("@beizhu1",SqlDbType.VarChar,50);

                pbianma_yy.Value = bianma_yy;
                pbianma_liushui.Value = bianma_liushui3;
                pxmmc.Value = xmmc_k;
                pxmzrr.Value = xmzrr_k;
                pcjbm.Value = cjbm_k;             
                pdate.Value = date_k;
                pweek.Value = week_k;
                psjd.Value = sjd_k;
                pkcmc.Value = kcmc_k;
                plkjs.Value = lkjs_k;
                pphone.Value = phone_k;
                pbeizhu.Value = beizhu_k;               

                // SqlCommand cmd = new SqlCommand(sql,new SqlHelper().sql(conn));
                conn.Open();             
                int count = cmd.ExecuteNonQuery();
                conn.Close();
                if (count > 0)
                {                    
                    context.Response.Write("1"+"##"+bianma_liushui3);//预约成功
                                       
                }
                else
                {
                    context.Response.Write("0");//预约失败
                }  
            }           
            context.Response.End();//必不可少，不然360极速浏览器会出错   
        }  
       }      
        
        //查询时间段是否已占用
       public static bool checkDateSjd_exist(string date_e,string sjd_e)
       {
           ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
           //string username_k = yanzheng.Filter(username_e); 
           string date_k = yanzheng.Filter(date_e);
           string sjd_k = yanzheng.Filter(sjd_e);         

           string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
           SqlConnection conn = new SqlConnection(connStr);
           string sql = "select lkjs,date,sjd from lkzxyy where date=@date2 and sjd=@sjd2";
           SqlCommand cmd = new SqlCommand(sql, conn);
           ///参数化查询解决非法字符问题，并限制长度，第3层防护
           //SqlParameter pusername = cmd.Parameters.Add("@username2", SqlDbType.VarChar, 18);
           SqlParameter pdate = cmd.Parameters.Add("@date2", SqlDbType.VarChar, 30);
           SqlParameter psjd = cmd.Parameters.Add("@sjd2", SqlDbType.VarChar, 30);        

           //pusername.Value = username_k;
           pdate.Value = date_k;
           psjd.Value = sjd_k; 
          
           conn.Open();
           SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
           //conn.Close();         
           if (sdr.Read())
           {
               return true;//时间段已被占用
               
           }
           else
           {
               return false;//时间段空闲可以使用
           }
           //sdr.Close();      
           conn.Close();
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
            string str = date_c;
            //string pattern = @"^(d{4})-(d{2})-(d{2})$";   //匹配/和hp之间的字符
            string pattern = @"^\d{4}-\d{2}-\d{2}$"; 
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