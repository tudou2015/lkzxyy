<%@ WebHandler Language="C#" Class="yy_chaxun.download" %>

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

namespace yy_chaxun 
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class download : IHttpHandler,IRequiresSessionState
    {
        [WebMethod(EnableSession = true)]
        public void ProcessRequest (HttpContext context) 
        {
            //context.Response.ContentType = "text/plain";
            context.Response.ContentType = "application/ms-download"; //解决360极速浏览器chrome内核不兼容问题       
           //接收到的数据
       // string username_c = context.Request.Form["username"];
            string file1_c=context.Request.QueryString["file1"].ToString();
         
      
         //检查输入的规范性，第1层防护
           if (!checkFile1(file1_c))
           {
               ///不规范的做记录
               //writeinto_hacklog();
               context.Response.Write("2");//不符合数据库规范，已被记录       
           }
           else
           {
               //if (checkJneirong_exist(jneirong_c))
               
               if (!checkFile1_exist(file1_c))
               {
                   context.Response.Write("3此文件不存在，请重新输入文件编号");  //此文件不存在存在
               }
               else
               {
                   ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
                   //string username_k = yanzheng.Filter(username_c);
                   string file1_k = yanzheng.Filter(file1_c);

                   //context.Response.ContentType = "text/plain";

                   string path = context.Server.UrlDecode(context.Request.QueryString["file1"].ToString());

                   //string fileName = Path.GetFileName(path);//文件名
//string filename = FileHelper.Decrypt(Request["fn"]); //通过解密得到文件名
                       string filename = context.Request["file1"];
                   
                   //string filePath = context.Server.MapPath("../uploads/"+fileName);//路径  
                       //string filepath = HttpContext.Current.Server.MapPath("~/") + "files/" + filename; //待下载的文件路径
                       string filepath = context.Server.MapPath("../uploads/" + filename);
                      
                   //if (File.Exists(filePath))
                   if (File.Exists(filepath))
                   {

                       System.IO.Stream iStream = null;

                       byte[] buffer = new Byte[10240];

                       int length;

                       long dataToRead;

                      iStream = new System.IO.FileStream(filepath, System.IO.FileMode.Open,
                           System.IO.FileAccess.Read, System.IO.FileShare.Read);
                       context.Response.Clear();

                       dataToRead = iStream.Length;

                       long p = 0;
                       //Int64 p = 0;
                       if (context.Request.Headers["Range"] != null)
                       {
                           context.Response.StatusCode = 206;
                           p = long.Parse(context.Request.Headers["Range"].Replace("bytes=", "").Replace("-", ""));
                           //p = Int64.Parse(context.Request.Headers["Range"].Replace("bytes=", "").Replace("-", ""));
                       }
                       if (p != 0)
                       {
                           context.Response.AddHeader("Content-Range", "bytes " + p.ToString() + "-" + ((long)(dataToRead - 1)).ToString() + "/" + dataToRead.ToString());
                       }
                       context.Response.AddHeader("Content-Length", ((long)(dataToRead - p)).ToString());
                       context.Response.ContentType = "application/octet-stream";
                       context.Response.AddHeader("Content-Disposition", "attachment; filename=" + System.Web.HttpUtility.UrlEncode(System.Text.Encoding.GetEncoding(65001).GetBytes(Path.GetFileName(filename))));

                       iStream.Position = p;
                       dataToRead = dataToRead - p;

                       while (dataToRead > 0)
                       {
                           if (context.Response.IsClientConnected)
                           {
                               length = iStream.Read(buffer, 0, 10240);

                               context.Response.OutputStream.Write(buffer, 0, length);
                               context.Response.Flush();

                               buffer = new Byte[10240];
                               dataToRead = dataToRead - length;
                           }
                           else
                           {
                               dataToRead = -1;
                           }
                       }

                       if (iStream != null)
                       {
                           iStream.Close();
                           context.Response.End();
                       }
                       ////以字符流的形式下载文件
                       //FileStream fs = new FileStream(filePath, FileMode.Open);
                       //byte[] bytes = new byte[(int)fs.Length];
                       //fs.Read(bytes, 0, bytes.Length);
                       //fs.Close();
                       
                       //context.Response.Clear();
                       //context.Response.ClearHeaders();
                       //context.Response.Buffer = false;
                       //context.Response.ContentType = "application/octet-stream";
                       ////通知浏览器下载文件而不是打开
                       ////string ff = HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8);
                       //context.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                       ////context.Response.AddHeader("Content-Disposition", "attachment; filename=" + ff+";");
                       ////context.Response.AddHeader("content-disposion","attachment;filename=\""+ff+"\"");
                       ////context.Response.AppendHeader("Content-Disposition", "attachment;filename=\"" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.ASCII)+"\"");
                       ////context.Response.AppendHeader("Content-Length", fileName.Length.ToString());
                       //context.Response.BinaryWrite(bytes);
                       ////context.Response.Redirect(filePath);
                       //context.Response.Flush();
                       //context.Response.Clear();
                       //context.Response.End();
                       ////context.Response.Redirect(filePath);
                   }
                   else
                   {
                       context.Response.Write("未上传文件!!");
                       context.Response.End();
                   }      
                 
                   //string week_k = CaculateWeekDay(date_k);

                 


                 

                   //// SqlCommand cmd = new SqlCommand(sql,new SqlHelper().sql(conn));
                   //conn.Open();
                   //int count = cmd.ExecuteNonQuery();
                   //conn.Close();
                   //if (count > 0)
                   //{
                   //    context.Response.Write("1" + "##" + bianma_liushui3);//预约成功

                   //}
                   //else
                   //{
                   //    context.Response.Write("0");//预约失败
                   //}
                   
                    //////////////////////////////////
                   
                   //if (context.Request.Files.Count > 0)
                   //{
                   //    HttpPostedFile file = context.Request.Files["fileToUpload"];
                   //    string fileName = file.FileName;
                   //    //fileName = context.Server.MapPath("../uploads/" + fileName);
                   //    fileName = context.Server.MapPath("../uploads/" + bianma_liushui3+"."+ fileName.Substring(fileName.LastIndexOf(".")+1));
                   //    file.SaveAs(fileName);

                   //    string result = "File Saved Successfully";

                   //    context.Response.ContentType = "text/plain";
                   //    context.Response.Write(result);
                   //}
                   //else
                   //{
                   //    string result = "请选择需要上传文件";
                   //    context.Response.ContentType = "text/plain";
                   //    context.Response.Write(result);
                   //}
                   ////////////////////////////////////   
                   
               }
           }    
              
             //context.Response.End();//必不可少，不然360极速浏览器会出错
           //context.Response.Redirect("../ajax_yy/yy_download.ashx?file1_c="+file1_c);   

           }
     
        


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        
       public static bool checkFile1(string file1_c)
        {
            //checkJneirong_exist(jneirong_c)
            string str = file1_c;
            string pattern = @"^\d{3}$|\d{9}.(mp3|wav|mp4)$";
                          // @"^\d{1,2}:\d{2}~\d{1,2}:\d{2}$"
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
        
        public static bool checkFile1_exist(string file1_c)
        {
            //checkJneirong_exist(jneirong_c)
             ///过滤非法字符，';--等，防止欺骗性规范，第2层防护
            string file1_k =yanzheng.Filter(file1_c);
          
            string connStr = ConfigurationManager.ConnectionStrings["yyvodConnectionString"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string sql_chaxun_download = "select bianma_liushui,kcmc,jneirong,lkjs,file1 from lsxxb where file1=@file13";
            SqlCommand cmd = new SqlCommand(sql_chaxun_download, conn);
            ///参数化查询解决非法字符问题，并限制长度，第3层防护           
            SqlParameter pfile1 = cmd.Parameters.Add("@file13",SqlDbType.VarChar,30);           
            pfile1.Value = file1_k;

            conn.Open();
            SqlDataReader sdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            //conn.Close();         
            if (sdr.Read())
            {
                return true;//此文件存在

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