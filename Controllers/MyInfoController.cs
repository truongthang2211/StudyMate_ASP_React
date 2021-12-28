using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;
namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
public class MyInfoController : ControllerBase
{

    [Route("api/update-myinfo"), HttpPost]
    public JsonResult UpdateMyInfo()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        string Email = (string)data.Email;

        var context = new DBContext();

        var user = (from u in context.users
                    where u.Email == Email
                    select u).FirstOrDefault();

        user.Fullname = (string)data.Fullname;
        user.Date_of_birth = (string)data.Date_of_birth;
        user.City_id = (string)data.City_id;
        user.Phone = (int)data.Phone;
        user.School = (string)data.School;
        user.Facebook = (string)data.Facebook;
        user.Bio = (string)data.Bio;

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


    [Route("api/update-password"), HttpPut]
    public JsonResult UpdatePassword()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        int Userid = (int)data.User_id;

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

}
