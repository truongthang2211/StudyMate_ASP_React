using System.Net.Http.Headers;
using System.Text.Json;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;
namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
[EnableCors("AllowSetOrigins")]
public class MyInfoController : ControllerBase
{

    [Route("update-myinfo"), HttpPost]
    public JsonResult UpdateMyInfo([FromForm] string data, [FromForm] IFormFile? avatar_img = null, [FromForm] IFormFile? background_img = null)
    {
        try
        {
            dynamic? data2 = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(data);

            string Email = (string)data2.email;

            var context = new DBContext();
            var user = (from u in context.users
                        where u.Email == Email
                        select u).FirstOrDefault();

            user.Fullname = (string?)data2.fullname;
            user.Date_of_birth = Convert.ToDateTime(data2.date_of_birth);
            user.City_id = (int?)data2.city_id;
            user.Phone = (string?)data2.phone;
            user.School = (string?)data2.school;
            user.Facebook = (string?)data2.facebook;
            user.Bio = (string?)data2.bio;


            if (avatar_img != null)
            {
                var file = avatar_img;
                var path = Directory.GetCurrentDirectory() + @"\ClientApp\public\";
                var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                var FileExtension = Path.GetExtension(fileName);


                var newFileName = @"img/user/avatar/" + ((int)(DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds).ToString() + FileExtension;
                var PathDB = path + newFileName;
                user.Avatar_img = newFileName;
                using (FileStream fs = System.IO.File.Create(PathDB))
                {
                    file.CopyTo(fs);
                    fs.Flush();
                }
            }
            if (background_img != null)
            {
                var file = background_img;
                var path = Directory.GetCurrentDirectory() + @"\ClientApp\public\";
                var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                var FileExtension = Path.GetExtension(fileName);


                var newFileName = @"img/user/background/" + ((int)(DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds).ToString() + FileExtension;
                var PathDB = path + newFileName;
                user.Background_img = newFileName;
                using (FileStream fs = System.IO.File.Create(PathDB))
                {
                    file.CopyTo(fs);
                    fs.Flush();
                }
            }
            context.Update(user);
            context.SaveChanges();
            var result = new
            {
                status = 200,
                message = "User Updated Successfully",
                User = user,
            };
            return new JsonResult(result);
        }
        catch (Exception ex)
        {
            var result = new
            {
                status = 404,
                message = ex.ToString(),
            };
            return new JsonResult(result);
        }
    }


    [Route("update-password"), HttpPut]
    public JsonResult UpdatePassword()
    {
        try
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

            int Userid = (int)data.user_id;

            string currentPassword = (string)data.currentPassword;
            string newPassword = (string)data.newPassword;

            var context = new DBContext();

            var acc = (from a in context.accounts
                       where a.User_id == Userid
                       select a).FirstOrDefault();

            if (acc != null && BCrypt.Net.BCrypt.Verify(currentPassword, acc.Pwd))
            {
                acc.Pwd = BCrypt.Net.BCrypt.HashPassword(newPassword);
                context.Update(acc);
                context.SaveChanges();

                var result = new
                {
                    status = 200,
                    message = "Password Updated Successfully",
                    Account = acc,
                };
                return new JsonResult(result);
            }
            else
            {
                var result = new
                {
                    status = 404,
                    message = "Fails",
                };
                return new JsonResult(result);
            }
        }
        catch (Exception ex)
        {
            var result = new
            {
                status = 404,
                message = ex.InnerException,
            };
            return new JsonResult(result);
        }

    }
}
