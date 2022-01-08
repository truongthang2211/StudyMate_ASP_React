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
public class ProfileController : ControllerBase
{
    [Route("get-city"), HttpPost]
    public JsonResult GetCity()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        int Cityid = (int)data.City_id;
        var context = new DBContext();

        var city = from c in context.cities
                   where c.City_id == Cityid
                   select c;

        var result = new
        {
            status = 200,
            city = city,
        };
        return new JsonResult(result);
    }


    [Route("get-course-item"), HttpPost]
    public JsonResult GetProfileCourseItem()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
        int Userid = (int)data.User_id;
        var context = new DBContext();
        var courses = (from u in context.users
                       join l in context.learnings on u.User_id equals l.User_id
                       join less in context.lessons on l.Lesson_id equals less.Lesson_id
                       join cp in context.course_chapters on less.Chapter_id equals cp.Course_chapter_id
                       join c in context.courses on cp.Course_id equals c.Course_id
                       where u.User_id == Userid
                       orderby l.Learn_time descending
                       select new { c.Course_id, c.Course_name, c.Img, c.Author_id }).Take(3);

        var result = new
        {
            status = 200,
            courses = courses,
        };
        return new JsonResult(result);
    }


    [Route("get-course-info"), HttpPost]
    public JsonResult GetCourseInfo()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        int Userid = (int)data.User_id;
        var context = new DBContext();
        var learntCourse = (from c in context.courses
                            join e in context.enrollments on c.Course_id equals e.Course_id
                            join u in context.users on e.User_id equals u.User_id
                            where u.User_id == Userid
                            select c).Count();

        var uppedCourse = (from c in context.courses
                           join u in context.users on c.Author_id equals u.User_id
                           where u.User_id == Userid
                           select c).Count();

        var result = new
        {
            status = 200,
            learntCourse = learntCourse,
            uppedCourse = uppedCourse
        };
        return new JsonResult(result);
    }

    [Route("get-author"), HttpPost]
    public JsonResult GetAuthor()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        int Courseid = (int)data.Course_id;
        var context = new DBContext();

        var author = from c in context.courses
                     join u in context.users on c.Author_id equals u.User_id
                     where c.Course_id == Courseid
                     select u; //id, fullname

        var result = new
        {
            status = 200,
            author = author,
        };
        return new JsonResult(result);
    }

}
