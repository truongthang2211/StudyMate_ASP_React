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
        if (emailExist != null && accountExist != null)
        {
            User u = new User();
            u.Fullname = Account;
            u.Email = UserEmail;
            context.users.Add(u);
            context.SaveChanges();
            context.Entry(u).GetDatabaseValues();

            Account acc = new Account();
            acc.Username = Account;
            // acc.Pwd = bcrypt(Password);
            acc.User_id = u.User_id;
            context.accounts.Add(acc);
            context.SaveChanges();

            return new JsonResult(u);


        }
        return new JsonResult(emailExist.FirstOrDefault());
    }
    [Route("sign-ups"), HttpPost]
    public JsonResult GetCurrentUser()
    {
        // var reader = new StreamReader(HttpContext.Request.Body);
        // var body = reader.ReadToEnd();
        // dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        // var context = new DBContext();
        // string UserEmail = (string)data.email;
        // UserEmail = UserEmail != null ? UserEmail : string.Empty;
        // var emailExist = from user in context.users where user.Email == UserEmail select user;
        // return new JsonResult(emailExist.FirstOrDefault());
        return new JsonResult("account");
    }
}
