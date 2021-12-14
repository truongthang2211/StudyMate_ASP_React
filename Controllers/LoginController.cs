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


    [Route("sign-up"), HttpPost]
    public JsonResult SignUp()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        var context = new DBContext();
        string UserEmail = (string)data.email;
        UserEmail = UserEmail != null ? UserEmail : string.Empty;
        var emailExist = from user in context.users where user.Email == UserEmail select user;
        return new JsonResult(emailExist.FirstOrDefault());
    }
    
}
