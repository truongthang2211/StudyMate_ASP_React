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
        try
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

            int Cityid = (int)data.city_id;
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


    [Route("get-course-item"), HttpPost]
    public JsonResult GetProfileCourseItem()
    {
        try
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
            int Userid = Int32.Parse((string)data.user_id);
            var context = new DBContext();

            var courses = (from les in context.lessons
                           join l in context.learnings on les.Lesson_id equals l.Lesson_id
                           join cp in context.course_chapters on les.Chapter_id equals cp.Course_chapter_id
                           join c in context.courses on cp.Course_id equals c.Course_id
                           join u in context.users on c.Author_id equals u.User_id
                           where l.User_id == Userid
                           orderby l.Learn_time descending
                           select new { c.Course_id, c.Course_name, c.Img, u.Fullname, u.User_id }).Distinct().Take(3);

            var learntCourse = (from c in context.courses
                                join e in context.enrollments on c.Course_id equals e.Course_id
                               join u in context.users on c.Author_id equals u.User_id
                               where e.User_id == Userid
                               where c.Course_state == "Công khai"
                               select new { c.Course_id, c.Course_name, c.Img, u.Fullname, u.User_id }).Distinct();

            var uppedCourse = from c in context.courses
                              join u in context.users on c.Author_id equals u.User_id
                              where c.Author_id == Userid
                              where c.Course_state == "Công khai"
                              select new { c.Course_id, c.Course_name, c.Img, u.Fullname, u.User_id };

            var result = new
            {
                status = 200,
                courses = courses,
                learntCourse = learntCourse,
                uppedCourse = uppedCourse
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


    // [Route("get-course-info"), HttpPost]
    // public JsonResult GetCourseInfo()
    // {
    //     var reader = new StreamReader(HttpContext.Request.Body);
    //     var body = reader.ReadToEnd();
    //     dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

    //     int Userid = (int)data.User_id;
    //     var context = new DBContext();
    //     var learntCourse = (from c in context.courses
    //                         join e in context.enrollments on c.Course_id equals e.Course_id
    //                         join u in context.users on e.User_id equals u.User_id
    //                         where u.User_id == Userid
    //                         select c).Count();

    //     var uppedCourse = (from c in context.courses
    //                        join u in context.users on c.Author_id equals u.User_id
    //                        where u.User_id == Userid
    //                        select c).Count();

    //     var result = new
    //     {
    //         status = 200,
    //         learntCourse = learntCourse,
    //         uppedCourse = uppedCourse
    //     };
    //     return new JsonResult(result);
    // }

    // [Route("get-author"), HttpPost]
    // public JsonResult GetAuthor()
    // {
    //     var reader = new StreamReader(HttpContext.Request.Body);
    //     var body = reader.ReadToEnd();
    //     dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

    //     int Courseid = (int)data.Course_id;
    //     var context = new DBContext();

    //     var author = from c in context.courses
    //                  join u in context.users on c.Author_id equals u.User_id
    //                  where c.Course_id == Courseid
    //                  select u; //id, fullname

    //     var result = new
    //     {
    //         status = 200,
    //         author = author,
    //     };
    //     return new JsonResult(result);
    // }

}
