<%@ WebHandler Language="C#" Class="yy_upload.upload" %>

using System; 
using System.Collections; 
using System.Data; 
using System.Drawing;
using System.Media;
using System.Linq; 
using System.IO;
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

namespace yy_upload 
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class upload : IHttpHandler,IRequiresSessionState
    {
        [WebMethod(EnableSession = true)]
        public void ProcessRequest (HttpContext context) 
        {
          context.Response.ContentType = "html"; //解决360极速浏览器chrome内核不兼容问题       
           //接收到的数据
       // string username_c = context.Request.Form["username"];
            string bianma_liushui_c=context.Request.Form["bianma_liushui"];
            string xmmc_c = context.Request.Form["xmmc_sc"];
            string xmzrr_c = context.Request.Form["xmzrr_sc"];
            string cjbm_c = context.Request.Form["cjbm_sc"];
         string kcmc_c=context.Request.Form["kcmc_sc"];
            string jneirong_c=context.Request.Form["jneirong_sc"];
            string lkjs_c = context.Request.Form["lkjs_sc"];
            string phone_c = context.Request.Form["phone_sc"];
            string editor1_c=context.Request.Form["editor_sc"];
           //string beizhu_c=context.Request.Form["beizhu_sc"];
            string extend_c=context.Request.Form["extend_sc"];
      
         //检查输入的规范性，第1层防护
           if (!checkJneirong(jneirong_c))
           {
               ///不规范的做记录
               //writeinto_hacklog();
               context.Response.Write("2##包含危险字符");//不符合数据库规范，已被记录       
           }
           else
           {
               //if (checkJneirong_exist(jneirong_c))
               
               if (checkJneirong_exist(jneirong_c))
               {
                   context.Response.Write("3此讲已存在，不要重复上传");  //此讲已存在
               }
               else
               {
                   ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
                   //string username_k = yanzheng.Filter(username_c);
                   string bianma_liushui_k = yanzheng.Filter(bianma_liushui_c);
                   string xmmc_k = yanzheng.Filter(xmmc_c);
                   string xmzrr_k = yanzheng.Filter(xmzrr_c);
                   string cjbm_k = yanzheng.Filter(cjbm_c);
                   string kcmc_k = yanzheng.Filter(kcmc_c);
                   string jneirong_k = yanzheng.Filter(jneirong_c);
                   string lkjs_k = yanzheng.Filter(lkjs_c);
                   string phone_k = yanzheng.Filter(phone_c);
                   string editor1_k=yanzheng.Filter(editor1_c);
                   //string beizhu_k = yanzheng.Filter(beizhu_c);
                   string extend_k = yanzheng.Filter(extend_c);
                
                   //string week_k = CaculateWeekDay(date_k);

                   Random sjm = new Random();
                   double suijima = sjm.NextDouble();
                   Int32 suijima_four = (Int32)(suijima * 10000);
                   string suijima_weiyi = suijima_four.ToString("d4");
                   string TimeFormat = "yyyyMMddHHmmss";
                   string bianma_time = DateTime.Now.ToString(TimeFormat);
                   string bianma_yy = bianma_time.Trim() + suijima_weiyi.Trim() + "7";

                   string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
                   SqlConnection conn = new SqlConnection(connStr);

                   //生成流水号
                   //先写入nowdate_short
                   string sql_liushui0 = "update config set nowdate_short=@nowdate_short0 where flag=1";
                   SqlCommand cmd_liushui0 = new SqlCommand(sql_liushui0, conn);
                   SqlParameter pnowdate_short0 = cmd_liushui0.Parameters.Add("@nowdate_short0", SqlDbType.VarChar, 6);
                   pnowdate_short0.Value = DateTime.Now.ToString("yyyyMMdd").Substring(2);
                   conn.Open();
                   cmd_liushui0.ExecuteNonQuery();
                   conn.Close();

                   string sql_liushui = "select beforedate_short,nowdate_short,nowliushui,flag2 from config where flag=1";
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
                       if ((flag2 == null) || (flag2 == 0) || (beforedate_short != nowdate_short))
                       {
                           nowliushui = "001";
                           string sql_liushui1 = "update config set beforedate_short=nowdate_short,flag2=1,nowliushui='001',beforenum=nownum,added=1,nownum=nownum+1 where flag=1";
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
                           string date_k = DateTime.Now.ToString("yyyyMMdd");
                           string sql_liushui2 = "update config set beforedate_short=nowdate_short,nowdate_short=@nowdate_short,flag2=flag2+1,beforeliushui=nowliushui,nowliushui=nowliushui+1,beforenum=nownum,added=1,nownum=nownum+1 where flag=1";
                           SqlCommand cmd_liushui2 = new SqlCommand(sql_liushui2, conn);
                           SqlParameter pnowdate_short = cmd_liushui2.Parameters.Add("@nowdate_short", SqlDbType.VarChar, 6);
                           pnowdate_short.Value = date_k.Replace("-", "").Substring(2);
                        
                           conn.Open();
                           cmd_liushui2.ExecuteNonQuery();
                           conn.Close();
                       }

                   }
                   else { sdr.Close(); }
                   //sdr.Close();
                   conn.Close();

                   //获取流水号
                   string sql_liushui3 = "select nowdate_short,nowliushui from config where flag=1";
                   string bianma_liushui3 = null;
                   SqlCommand cmd_liushui3 = new SqlCommand(sql_liushui3, conn);
                   conn.Open();
                   SqlDataReader sdr3 = cmd_liushui3.ExecuteReader(CommandBehavior.CloseConnection);
                   if (sdr3.Read())
                   {
                       string nowdate_short3 = sdr3[0].ToString();
                       string nowliushui3 = sdr3[1].ToString();
                       bianma_liushui3 = nowdate_short3 + nowliushui3.PadLeft(3, '0');

                   }
                   //sdr.Close();        
                   conn.Close();


                   //string sql = "insert into lkzxyy(bianma,bianma_liushui,xmmc,xmzrr,cjbm,date,week,sjd,lkjs,phone,beizhu) values(@bm1,@bianma_liushui1,@xmmc1,@xmzrr1,@cjbm1,@date1,@week1,@sjd1,@lkjs1,@phone1,@beizhu1);insert into gzjdd(bianma,bianma_liushui,xmmc,xmzrr,cjbm,lkjs,phone,beizhu) values(@bm1,@bianma_liushui1,@xmmc1,@xmzrr1,@cjbm1,@lkjs1,@phone1,@beizhu1)";
                   string sql_sc = "update lkzxyy set upload='已上传音频' where bianma_liushui=@bianma_liushui22;insert into lsxxb(bianma,bianma_liushui,xmmc,xmzrr,cjbm,kcmc,jneirong,lkjs,phone,file1,editor,steps,completed) values(@bm1,@bianma_liushui1,@xmmc1,@xmzrr1,@cjbm1,@kcmc1,@jneirong1,@lkjs1,@phone1,@file11,@editor1,@steps1,@completed1);insert into lsjdb(bianma,bianma_liushui,jneirong,lkjs,phone,jindu,time,editor,step,completed) values(@bm1,@bianma_liushui1,@jneirong1,@lkjs1,@phone1,@jindu1,@time1,@editor1,@step1,@completed1)";
                   SqlCommand cmd = new SqlCommand(sql_sc, conn);
                   ///参数化查询解决非法字符问题，并限制长度，第3层防护
                   SqlParameter pbianma_liushui22=cmd.Parameters.Add("@bianma_liushui22",SqlDbType.VarChar,9);
                   SqlParameter pbianma_yy = cmd.Parameters.Add("@bm1", SqlDbType.VarChar, 19);
                   SqlParameter pbianma_liushui = cmd.Parameters.Add("@bianma_liushui1", SqlDbType.VarChar, 9);
                   SqlParameter pxmmc = cmd.Parameters.Add("@xmmc1", SqlDbType.VarChar, 50);
                   SqlParameter pxmzrr = cmd.Parameters.Add("@xmzrr1", SqlDbType.VarChar, 30);
                   SqlParameter pcjbm = cmd.Parameters.Add("@cjbm1", SqlDbType.VarChar, 30);
                   SqlParameter pkcmc = cmd.Parameters.Add("@kcmc1",SqlDbType.VarChar,30);
                   SqlParameter pjneirong = cmd.Parameters.Add("@jneirong1",SqlDbType.VarChar,30);  
                   SqlParameter plkjs = cmd.Parameters.Add("@lkjs1", SqlDbType.VarChar, 30);
                   SqlParameter pphone = cmd.Parameters.Add("@phone1", SqlDbType.VarChar, 13);                   
                   SqlParameter pfile1 = cmd.Parameters.Add("@file11",SqlDbType.VarChar,30);
                   SqlParameter psteps1 = cmd.Parameters.Add("@steps1",SqlDbType.Int);
                   SqlParameter pcompleted = cmd.Parameters.Add("@completed1",SqlDbType.VarChar,12);
                   //SqlParameter pbeizhu = cmd.Parameters.Add("@beizhu1", SqlDbType.VarChar, 50);
                   
                   SqlParameter pjindu1 = cmd.Parameters.Add("@jindu1",SqlDbType.VarChar,30);
                   SqlParameter ptime1 = cmd.Parameters.Add("@time1",SqlDbType.VarChar,30);
                   SqlParameter peditor1 = cmd.Parameters.Add("@editor1", SqlDbType.VarChar,12);
                   SqlParameter pstep1 = cmd.Parameters.Add("@step1", SqlDbType.Int);

                   pbianma_liushui22.Value = bianma_liushui_k;
                   pbianma_yy.Value = bianma_yy;
                   pbianma_liushui.Value = bianma_liushui3;
                   pxmmc.Value = xmmc_k;
                   pxmzrr.Value = xmzrr_k;
                   pcjbm.Value = cjbm_k;
                   pkcmc.Value = kcmc_k;
                   pjneirong.Value = jneirong_k;
                   plkjs.Value = lkjs_k;
                   pphone.Value = phone_k;                  
                   pfile1.Value=bianma_liushui3+"."+extend_k;
                   psteps1.Value = 1;
                   pcompleted.Value = "未完成";
                   //pbeizhu.Value = null;     

                   pjindu1.Value = "录音完成并上传";
                   ptime1.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                   //peditors1.Value += editor1_k;
                   peditor1.Value = editor1_k;
                   pstep1.Value = 1;                                

                   // SqlCommand cmd = new SqlCommand(sql,new SqlHelper().sql(conn));
                   conn.Open();
                   int count = cmd.ExecuteNonQuery();
                   conn.Close();
                   if (count > 0)
                   {
                       //context.Response.Write("1" + "##" +"预约成功,本次预约流水号："+ bianma_liushui3+"后期编辑人员"+editor1_k+"将尽快与您联系。");//预约成功
                       context.Response.Write("1" + "##" + bianma_liushui3 );//预约成功
                   }
                   else
                   {
                       context.Response.Write("0");//预约失败
                   }
                   
                    //////////////////////////////////
                   
                   if (context.Request.Files.Count > 0)
                   {
                       HttpPostedFile file = context.Request.Files["fileToUpload"];
                       string fileName = file.FileName;
                       //fileName = context.Server.MapPath("../uploads/" + fileName);
                       fileName = context.Server.MapPath("../uploads/" + bianma_liushui3+"."+ fileName.Substring(fileName.LastIndexOf(".")+1));
                       file.SaveAs(fileName);

                       string result = "File Saved Successfully";

                       context.Response.ContentType = "text/plain";
                       context.Response.Write(result);
                   }
                   else
                   {
                       string result = "请选择需要上传文件";
                       context.Response.ContentType = "text/plain";
                       context.Response.Write(result);
                   }
                   ////////////////////////////////////   
                   
               }
           }    
              
             context.Response.End();//必不可少，不然360极速浏览器会出错   

           }
     
        


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        
       public static bool checkJneirong(string jneirong_c)
        {
            //checkJneirong_exist(jneirong_c)
            string str = jneirong_c;
            string pattern = @"^\d{3}$|^[\u4e00-\u9fa5A-Za-z0-9]{2,30}$";
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
            //return false;
        
        }
        
        public static bool checkJneirong_exist(string jneirong_c)
        {
            //checkJneirong_exist(jneirong_c)
            string jneirong_k =yanzheng.Filter(jneirong_c);
           // return false;

            ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
            //string username_k = yanzheng.Filter(username_e); 
            //string date_k = yanzheng.Filter(date_e);
           // string sjd_k = yanzheng.Filter(sjd_e);

            string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string sql = "select bianma_liushui,kcmc,jneirong,lkjs from lsxxb where jneirong=@jneirong2";
            SqlCommand cmd = new SqlCommand(sql, conn);
            ///参数化查询解决非法字符问题，并限制长度，第3层防护
            //SqlParameter pusername = cmd.Parameters.Add("@username2", SqlDbType.VarChar, 18);
            //SqlParameter pdate = cmd.Parameters.Add("@date2", SqlDbType.VarChar, 30);
            //SqlParameter psjd = cmd.Parameters.Add("@sjd2", SqlDbType.VarChar, 30);
            SqlParameter pjneirong = cmd.Parameters.Add("@jneirong2",SqlDbType.VarChar,30);

            //pusername.Value = username_k;
            //pdate.Value = date_k;
            //psjd.Value = sjd_k;
            pjneirong.Value = jneirong_k;

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
 
        public static string UploadImage(byte[] imgBuffer, string uploadpath, string ext)
        {
            try
            {
                System.IO.MemoryStream m = new MemoryStream(imgBuffer);
 
                if (!Directory.Exists(HttpContext.Current.Server.MapPath(uploadpath)))
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath(uploadpath));
 
                string imgname = CreateIDCode() + "." + ext;
 
                string _path = HttpContext.Current.Server.MapPath(uploadpath) + imgname;
 
                Image img = Image.FromStream(m);
                if (ext == "jpg")
                    img.Save(_path, System.Drawing.Imaging.ImageFormat.Jpeg);
                else
                    img.Save(_path, System.Drawing.Imaging.ImageFormat.Gif);
                m.Close();
 
                return uploadpath + imgname;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
 
        }
 
        public static string CreateIDCode()
        {
            DateTime Time1 = DateTime.Now.ToUniversalTime();
            DateTime Time2 = Convert.ToDateTime("1970-01-01");
            TimeSpan span = Time1 - Time2;   //span就是两个日期之间的差额   
            string t = span.TotalMilliseconds.ToString("0");
 
            return t;
        }
   
}

}