using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
public class AdminController : ControllerBase
{
    [Route("em-dep-lam"), HttpGet]
    public JsonResult CourseList()
    {
        var context = new DBContext();
        var products = context.Database.ExecuteSqlRawAsync("SELECT * FROM COURSES");
        return new JsonResult(products);
    }

    
    
}
