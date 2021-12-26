using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;
using System.Collections;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
public class CourseController : ControllerBase
{
    [Route("get-upvote"), HttpGet]
    public int GetUpvote(int Course_id)
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);

        var context = new DBContext();
        var total_upvote = (from cv in context.course_reviews
                            where cv.Course_id == Course_id
                            where cv.Course_review_state == 1
                            select cv).Count();
        return total_upvote;
    }

    [Route("get-downvote"), HttpGet]
    public int GetDownvote(int Course_id)
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);

        var context = new DBContext();
        var total_downvote = (from cv in context.course_reviews
                              where cv.Course_id == Course_id
                              where cv.Course_review_state == 0
                              select cv).Count();
        return total_downvote;
    }

    [Route("get-courses"), HttpGet]
    public JsonResult GetCourses()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);

        var context = new DBContext();
        ArrayList courses = new ArrayList();
        var course_list = from c in context.courses
                          join user in context.users on c.Author_id equals user.User_id
                          where c.Course_state == "Công khai"
                          select c;
        foreach (var course in course_list)
        {
            int total_upvote = GetUpvote(course.Course_id);
            int total_downvote = GetDownvote(course.Course_id);
            var obj = new
            {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote
            };
            courses.Add(obj);
        }
        return new JsonResult(
            new
            {
                message = courses,
                status = 200
            }
        );
    }

    [Route("get-courses-homepage"), HttpGet]
    public JsonResult GetCoursesHomepage()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);

        var context = new DBContext();
        ArrayList courses = new ArrayList();
        ArrayList result1 = new ArrayList();
        ArrayList result2 = new ArrayList();
        var courseMainType1 = (from c in context.course_maintypes
                               where c.Type_name == "Tin học văn phòng"
                               select c).First();
        var courseMainType2 = (from c in context.course_maintypes
                               where c.Type_name == "Công nghệ thông tin"
                               select c).First();
        var course1 = from c in context.courses
                        join user in context.users on c.Author_id equals user.User_id
                        join cst in context.course_subtypes on c.Course_type_id equals cst.Course_subtype_id
                        where cst.Parent_type_id == courseMainType1.Course_maintype_id
                        where c.Course_state == "Công khai"
                        select c;
        foreach (var course in course1)
        {
            int total_upvote = GetUpvote(course.Course_id);
            int total_downvote = GetDownvote(course.Course_id);
            var obj = new {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote
            };
            result1.Add(obj);
        }
        var course2 = from c in context.courses
                        join user in context.users on c.Author_id equals user.User_id
                        join cst in context.course_subtypes on c.Course_type_id equals cst.Course_subtype_id
                        where cst.Parent_type_id == courseMainType2.Course_maintype_id
                        where c.Course_state == "Công khai"
                        select c;
        foreach (var course in course2)
        {
            int total_upvote = GetUpvote(course.Course_id);
            int total_downvote = GetDownvote(course.Course_id);
            var obj = new {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote
            };
            result2.Add(obj);
        }
        var result = new
        {
            tinhocvanphong = result1,
            cntt = result2
        };
        return new JsonResult(new
        {
            message = result,
            status = 200
        });
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
