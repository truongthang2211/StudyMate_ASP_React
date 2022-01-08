using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
public class LoginController : ControllerBase
{
    private readonly IConfiguration _configuration;

    public LoginController(IConfiguration configuration)
    {
        _configuration = configuration;
    }


    [Route("sign-up"), HttpPost]
    public JsonResult SignUp()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        var context = new DBContext();
        string UserEmail = (string)data.email;
        string Account = (string)data.username;
        string Password = (string)data.password;
        UserEmail = UserEmail != null ? UserEmail : string.Empty;
        var emailExist = from user in context.users where user.Email == UserEmail select user;
        var accountExist = from acc in context.accounts where acc.Username == Account select acc;
        if (emailExist == null && accountExist == null)
        {
            User u = new User();
            u.Fullname = Account;
            u.Email = UserEmail;
            context.users.Add(u);
            context.SaveChanges();
            context.Entry(u).GetDatabaseValues();

            Account acc = new Account();
            acc.Username = Account;
            acc.Pwd = BCrypt.Net.BCrypt.HashPassword(Password);
            acc.User_id = u.User_id;
            context.accounts.Add(acc);
            context.SaveChanges();
            Set("StudyMate", u.User_id.ToString(), 60 * 24);
            return new JsonResult(new { status = 200, message = "Đăng ký thành công" });


        }
        return new JsonResult(new { status = 400, message = "Email hoặc username đã tồn tại" });
    }


    // }
    [Route("sign-in"), HttpPost]
    public JsonResult SignIn()
    {

        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        string Username = (string)data.username;
        string passw = (string)data.password;
        int statuscode = 200;
        string message = "Đăng nhập thành công";
        var context = new DBContext();
        var User = (from user in context.users where user.Email == Username select user).FirstOrDefault();
        var Account = (from acc in context.accounts where acc.Username == Username select acc).FirstOrDefault();
        var ID = User != null ? User.User_id : (Account != null ? Account.User_id : -1);
        Account = Account != null ? Account : (from acc in context.accounts where acc.User_id == ID select acc).FirstOrDefault();
        if (Account != null || User != null)
        {
            if (BCrypt.Net.BCrypt.Verify(passw, Account.Pwd))
            {
                Set("StudyMate", ID.ToString(), 60 * 24);

            }
            else
            {
                statuscode = 400;
                message = "Sai mật khấu";
            }
        }
        else
        {
            statuscode = 400;
            message = "Email hoặc username không tồn tại";
        }
        return new JsonResult(new
        {
            status = statuscode,
            message = message
        });
    }
    public JsonResult SignOut()
    {
        if (Get("StudyMate") != null)
        {
            Remove("StudyMate");
        }
         return new JsonResult(new
        {
            status = 200,
            message = "Sign out thanh cong"
        });
    }
    public JsonResult GetCurrentUser(){
        if (Get("CurrentUser") != null){
            string id = Get("CurrentUser");
            DBContext context = new DBContext();
            var user = (from u in context.users where u.User_id.ToString()== id select u).FirstOrDefault();
            return new JsonResult(new{ status=200,message="Lay User thanh cong",user=user});
        }else{
            return new JsonResult(new{ 
                status = 200,
                message = "Cookies het han",
                user = (User)null
            });
        }
    }
    public string? Get(string key)
    {
        return Request.Cookies[key];
    }

    public void Set(string key, string value, int? expireTime)
    {
        CookieOptions option = new CookieOptions();
        if (expireTime.HasValue)
            option.Expires = DateTime.Now.AddMinutes(expireTime.Value);
        else
            option.Expires = DateTime.Now.AddMilliseconds(10);
        Response.Cookies.Append(key, value, option);
    }

    public void Remove(string key)
    {
        Response.Cookies.Delete(key);
    }
}
