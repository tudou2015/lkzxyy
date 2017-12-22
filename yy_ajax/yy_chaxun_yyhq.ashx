<%@ WebHandler Language="C#" Class="Website.Ajax_chaxun.yyhq" %>

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
using Newtonsoft.Json;
using Newtonsoft.Json.Linq; 
using System.Text.RegularExpressions;
using yanzheng_tools;

namespace Website.Ajax_chaxun 
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class yyhq : IHttpHandler, IRequiresSessionState
    {
       [WebMethod(EnableSession = true)]
        public void ProcessRequest(HttpContext context)
        {      
            context.Response.ContentType = "html"; //解决360极速浏览器chrome内核不兼容问题       
           //接收到的数据
       // string username_c = context.Request.Form["username"];           
           //string phone_c=context.Request.Form["phone_chaxun"];
            //string cc = context.Request.Form["records"].ToString();
           bool flag=Convert.ToBoolean( context.Request.Form["flag"]);
           string records_c=context.Request.Form["records"];
           string phone_c=context.Request.Form["phone"];

            JArray ja = (JArray)JsonConvert.DeserializeObject(records_c);
            var count = ja.Count;
             bool flag2 = false;
             string[] liushui = new string[count];
             string liushui2 = null;
            for (int i = 0; i < count; i++)
            {
                if (Convert.ToInt32(ja[i]["checked"]) == 1) {
                    //JObject o = (JObject)ja[i];
                    flag2 = true;
                    liushui[i]=Convert.ToString(ja[i]["bianma_liushui"]);
                    liushui2 = liushui2 + Convert.ToString(ja[i]["bianma_liushui"]) + ",";
                }
            }
            liushui2 = liushui2.Substring(0,liushui2.Length-1);
            //JObject o = (JObject)ja[0];
            //string bianma_zero = o.bianma_liushui;
            //Console.WriteLine(o["a"]);
            //Console.WriteLine(ja[1]["a"]);           
           
            //JObject jo = JObject.Parse(cc);
            //string[] values = jo.Properties().Select(item => item.Value.ToString()).ToArray();
            //string cc3 = values[0]; 
            //Array cc2 = (Array)JsonConvert.DeserializeObject(cc);
            //string cc3 = cc2["checked"];          
            //JObject jo = JObject.Parse(cc);
            //string cc2 = jo.ToString();   
            //Array cc2 =(Array) JsonConvert.DeserializeObject(cc);
            //string cc3 = cc2[0]["checked"];
            //var cc3 = cc2.flag;
        
         //检查输入的规范性，第1层防护
        if (!flag)
        {
            ///不规范的做记录
            //writeinto_hacklog();
            context.Response.Write("2");//不符合数据库规范，已被记录       
        }
        else
        {
            if (!flag2)
            {
                context.Response.Write("5");  //没有这个号码
            }
            else
            {
                ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
                //string username_k = yanzheng.Filter(username_c);                
                string phone_k = yanzheng.Filter(phone_c);    

                Random sjm = new Random();
                double suijima = sjm.NextDouble();
                Int32 suijima_four = (Int32)(suijima * 10000);
                string suijima_weiyi = suijima_four.ToString("d4");
                string TimeFormat = "yyyyMMddHHmmss";
                string bianma_time = DateTime.Now.ToString(TimeFormat);
                string bianma_yy = bianma_time.Trim() + suijima_weiyi.Trim()+"3";                
                
                string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                //分配后期制作人员
                //AssignedWork(); 
                //string sql_min = "select editor,beforenum from editors where flag='true' order by beforenum";
                string sql_min = "select editor,beforenum from editors where flag='true' order by nownum";
                SqlCommand cmd_min = new SqlCommand(sql_min, conn);
                conn.Open();
                string cc = cmd_min.ExecuteScalar().ToString();
                conn.Close();                
                
                //string sql_chaxun_yyhq = "update lsxxb set yyhq=@yyhq2 where bianma_liushui in (" + liushui2 + ");select bianma_liushui,lkjs,jneirong,phone,file1,yyhq from lsxxb where phone=@phone3";
                //string sql_chaxun_yyhq = "update lsxxb set yyhq=@yyhq2 where bianma_liushui in ("+liushui2+");";
                string sql_chaxun_yyhq = "update lsxxb set yyhq=@yyhq2,editor2=@editor2 where bianma_liushui in ("+liushui2+");";
                SqlCommand cmd_yyhq = new SqlCommand(sql_chaxun_yyhq, conn);
                ///参数化查询解决非法字符问题，并限制长度，第3层防护                            
                
                //SqlParameter pliushui2 = cmd_yyhq.Parameters.Add("@liushui2",SqlDbType.VarChar,250);
                SqlParameter pyyhq2 = cmd_yyhq.Parameters.Add("@yyhq2",SqlDbType.VarChar,5);
                SqlParameter peditor2 = cmd_yyhq.Parameters.Add("@editor2", SqlDbType.VarChar, 5);    
                            
                //pliushui2.Value = liushui2.Trim();
                pyyhq2.Value = "已预约后期";
                peditor2.Value = cc;

                // SqlCommand cmd = new SqlCommand(sql,new SqlHelper().sql(conn));
                //conn.Open();             
                //int count = cmd.ExecuteNonQuery();
                //conn.Close();
                //if (count > 0)
                conn.Open();
                int rows=cmd_yyhq.ExecuteNonQuery();
                //cmd_yyhq.ExecuteScalar();
                conn.Close();

                string sql_chaxun = "select bianma_liushui,lkjs,jneirong,phone,file1,yyhq from lsxxb where phone=@phone3";
                SqlCommand cmd = new SqlCommand(sql_chaxun, conn);
                SqlParameter pphone = cmd.Parameters.Add("@phone3", SqlDbType.VarChar, 13);
                pphone.Value = phone_k;
                conn.Open(); 
                SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                object[] objValues = new object[sdr.FieldCount];
                DataTable dt = new DataTable();
                dt.Columns.Add("bianma_liushui");
                dt.Columns.Add("lkjs");
                dt.Columns.Add("jneirong");
                dt.Columns.Add("phone");
                dt.Columns.Add("file1");
                dt.Columns.Add("yyhq");
                dt.Columns.Add("editor");
                context.Response.Write("1##");//查询成功  
                while (sdr.Read())
                {
                    sdr.GetValues(objValues);
                    dt.LoadDataRow(objValues, false);
                }

                sdr.Close();

                context.Response.Write(JsonConvert.SerializeObject(dt));
                dt.EndLoadData();  
                //}
                //else
                //{
                //    context.Response.Write("0");//预约失败
                //}
                conn.Close();       
            }           
            context.Response.End();//必不可少，不然360极速浏览器会出错   
        }  
       }      
        
      
        
        //查询号码是否存在
       public static bool checkPhone_exist(string phone_e)
       {
           ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
           //string username_k = yanzheng.Filter(username_e);           
           string phone_k = yanzheng.Filter(phone_e);

           string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
           SqlConnection conn = new SqlConnection(connStr);
           string sql_exist = "select lkjs,jneirong,phone,file1 from lsxxb where phone=@phone3";
           SqlCommand cmd = new SqlCommand(sql_exist, conn);
           ///参数化查询解决非法字符问题，并限制长度，第3层防护
           //SqlParameter pusername = cmd.Parameters.Add("@username2", SqlDbType.VarChar, 18);          
           SqlParameter pphone = cmd.Parameters.Add("@phone3", SqlDbType.VarChar, 11);

           //pusername.Value = username_k;          
           pphone.Value = phone_k;

           //conn.Open();
           //int count = cmd.ExecuteNonQuery();
           //conn.Close();
           //if (count > 0)
           conn.Open();
           SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
           //conn.Close();         
           if (sdr.Read())
           {
               return true;//有这个号码

           }
           else
           {
               return false;//没有这个号码
           }
           //sdr.Close();      
           conn.Close();
           //return false;
       }
        
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
      
       
        // check phone
        public static bool checkPhone(string phone_c)
        {
            string str = phone_c;
            //string pattern = @"^(d{1,2}):(d{2}(-|~)(d{1,2})(d{2})$";   //匹配/和hp之间的字符
            string pattern = @"^\d{11}$";
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
    

    
    }

}