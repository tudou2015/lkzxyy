<%@ WebHandler Language="C#" Class="Website.Ajax_gl.chaxun" %>

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
using System.Text.RegularExpressions;
using yanzheng_tools;

namespace Website.Ajax_gl 
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class chaxun : IHttpHandler, IRequiresSessionState
    {
       [WebMethod(EnableSession = true)]
        public void ProcessRequest(HttpContext context)
        {      
            context.Response.ContentType = "html"; //解决360极速浏览器chrome内核不兼容问题       
           //接收到的数据
       // string username_c = context.Request.Form["username"];           
           string editor_c=context.Request.Form["name_editor_chaxun"];
        
         //检查输入的规范性，第1层防护
        if (!(checkEditor(editor_c)))
        {
            ///不规范的做记录
            //writeinto_hacklog();
            context.Response.Write("2");//不符合数据库规范，已被记录       
        }
        else
        {
            if (!checkEditor_exist(editor_c))
            {
                context.Response.Write("5");  //没有这个号码
            }
            else
            {
                ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
                //string username_k = yanzheng.Filter(username_c);                
                string editor_k = yanzheng.Filter(editor_c);
             
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
                string bianma_yy = bianma_time.Trim() + suijima_weiyi.Trim()+"3";
                
                string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                string sql_chaxun = "select bianma_liushui,jneirong,lkjs,phone,file1,editor2 from lsxxb where editor2=@editor3";
                SqlCommand cmd = new SqlCommand(sql_chaxun, conn);
                ///参数化查询解决非法字符问题，并限制长度，第3层防护                            
                SqlParameter peditor = cmd.Parameters.Add("@editor3",SqlDbType.VarChar,13);             
                peditor.Value = editor_k;              

                // SqlCommand cmd = new SqlCommand(sql,new SqlHelper().sql(conn));
                //conn.Open();             
                //int count = cmd.ExecuteNonQuery();
                //conn.Close();
                //if (count > 0)
                conn.Open();
                SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                //DataSet ds = new DataSet();
                //sda.Fill(ds);                
                //this.GridView1.DataSource = ds.Tables;
                //this.GridView1.DataBind();
                //object[] cc=null;
                //DataTable retDt = new DataTable();
                
                object[] objValues = new object[sdr.FieldCount];
                DataTable dt = new DataTable();
                dt.Columns.Add("bianma_liushui");
                dt.Columns.Add("jneirong");
                dt.Columns.Add("lkjs");
                dt.Columns.Add("phone");
                dt.Columns.Add("file1");
                dt.Columns.Add("editor2");
                context.Response.Write("1##");//查询成功  
                while (sdr.Read()) 
                { 
                     //cc=sdr[];
                    //cc = sdr["file1"].ToString();
                    //cc += sdr.GetString(sdr.GetOrdinal("file1"));
                    //cc = sdr;
                   // retDt = sdr;
                    sdr.GetValues(objValues);
                    dt.LoadDataRow(objValues,false);
                    //context.Response.Write("##");
                    //context.Response.Write(cc);
                    //cc[] = sdr[sdr.GetOrdinal("file1")];
                  
                }
                
                sdr.Close();
                
                //if (sdr.Read())
                //{ 
                //context.Response.Write("1");//查询成功                                      

                //string cc2 = "1" + "##" + cc;
                //string str = JsonConvert.SerializeObject(dt);
                //context.Response.Write(str);
                //Console.WriteLine(JsonConvert.SerializeObject(dt));
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
       public static bool checkEditor_exist(string editor_e)
       {
           ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
           //string username_k = yanzheng.Filter(username_e);           
           string editor_k = yanzheng.Filter(editor_e);

           string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
           SqlConnection conn = new SqlConnection(connStr);
           string sql_exist = "select jneirong,lkjs,phone,file1,editor2 from lsxxb where editor2=@editor3";
           SqlCommand cmd = new SqlCommand(sql_exist, conn);
           ///参数化查询解决非法字符问题，并限制长度，第3层防护
           //SqlParameter pusername = cmd.Parameters.Add("@username2", SqlDbType.VarChar, 18);          
           SqlParameter peditor = cmd.Parameters.Add("@editor3", SqlDbType.VarChar, 11);

           //pusername.Value = username_k;          
           peditor.Value = editor_k;

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

       // check phone
       public static bool checkEditor(string editor_c)
       {
           string str = editor_c;
           //string pattern = @"^(d{1,2}):(d{2}(-|~)(d{1,2})(d{2})$";   //匹配/和hp之间的字符
           //string pattern = @"^\w{2,5}$";
           string pattern = @"^[\u4e00-\u9fa5a-zA-Z]+$";/////////////????????
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
        
        
       
        
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
      
       
       

    
    }

}