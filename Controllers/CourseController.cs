using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
public class CourseController : ControllerBase
{

    
    [Route("em-dep-lam"), HttpGet]
    public JsonResult Get()
    {
        var context = new DBContext();
        var products = context.Database.ExecuteSqlRawAsync("SELECT * FROM COURSES");
        return new JsonResult(products);
    }
    [Route("em-dep-lam"), HttpPost]
    public JsonResult CreateorDelCourse()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        string json = @"{
                'Name': 'Bad Boys',
                'ReleaseDate': '1995-4-7T00:00:00',
                'Genres': [
                    'Action',
                    'Comedy'
                ]
                }";
        var test = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(json);
        return new JsonResult(test);
    }
}
