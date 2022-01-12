using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;
using System.Collections;
using Microsoft.AspNetCore.Cors;
using MySql.Data.MySqlClient;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
[EnableCors("AllowSetOrigins")]
public class CourseController : ControllerBase
{
    // Sub-function
    public int GetUpvote(int Course_id)
    {
        var context = new DBContext();
        var total_upvote = (from cv in context.course_reviews
                            where cv.Course_id == Course_id
                            where cv.Course_review_state == 1
                            select cv).Count();
        return total_upvote;
    }
    public int GetDownvote(int Course_id)
    {
        var context = new DBContext();
        var total_downvote = (from cv in context.course_reviews
                              where cv.Course_id == Course_id
                              where cv.Course_review_state == 0
                              select cv).Count();
        return total_downvote;
    }
    public IQueryable<User> GetCourseAuthor(int Author_id)
    {
        var context = new DBContext();
        var author = from user in context.users
                     where user.User_id == Author_id
                     select user;
        return author;
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
            IQueryable<User> author = GetCourseAuthor(course.Course_id);
            var obj = new
            {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote,
                author = author
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
            IQueryable<User> author = GetCourseAuthor(course.Course_id);
            var obj = new
            {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote,
                author = author
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
            IQueryable<User> author = GetCourseAuthor(course.Course_id);
            var obj = new
            {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote,
                author = author
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

    [Route("get-courses-by-subtype"), HttpPost]
    public JsonResult GetCoursesBySubtype()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
        var context = new DBContext();

        int id = (int)data.postData;
        ArrayList courses = new ArrayList();

        var course_list = from c in context.courses
                          join user in context.users on c.Author_id equals user.User_id
                          where c.Course_type_id == id
                          where c.Course_state == "Công khai"
                          select c;
        foreach (var course in course_list)
        {
            int total_upvote = GetUpvote(course.Course_id);
            int total_downvote = GetDownvote(course.Course_id);
            IQueryable<User> author = GetCourseAuthor(course.Course_id);
            var obj = new
            {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote,
                author = author
            };
            courses.Add(obj);
        }

        return new JsonResult(new
        {
            message = courses,
            status = 200
        });
    }

    [Route("get-courses-by-maintype"), HttpPost]
    public JsonResult GetCoursesByMaintype()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
        var context = new DBContext();

        int id = (int)data.postData;
        ArrayList courses = new ArrayList();

        var course_list = from c in context.courses
                          join user in context.users on c.Author_id equals user.User_id
                          join cst in context.course_subtypes on c.Course_type_id equals cst.Course_subtype_id
                          where cst.Parent_type_id == id
                          where c.Course_state == "Công khai"
                          select c;
        foreach (var course in course_list)
        {
            int total_upvote = GetUpvote(course.Course_id);
            int total_downvote = GetDownvote(course.Course_id);
            IQueryable<User> author = GetCourseAuthor(course.Course_id);
            var obj = new
            {
                course = course,
                upVote = total_upvote,
                downVote = total_downvote,
                author = author
            };
            courses.Add(obj);
        }
        return new JsonResult(new
        {
            message = courses,
            status = 200
        });
    }

    [Route("check-enrolled"), HttpPost]
    public JsonResult CheckEnrolled()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
            var context = new DBContext();

            int user_id = Convert.ToInt32(HttpContext.Request.Cookies["StudyMate"]);
            int course_id = (int)data.courseId;
            var ans = (from e in context.enrollments
                       where e.User_id == user_id
                       where e.Course_id == course_id
                       select e).FirstOrDefault();
            return new JsonResult(new
            {
                status = 200,
                message = ans
            });
        }
        else
        {
            return new JsonResult(new
            {
                status = 400,
                message = "Check enroll - Cookies het han"
            });
        }
    }

    [Route("check-owner"), HttpPost]
    public JsonResult CheckOwner()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
            var context = new DBContext();

            int user_id = Convert.ToInt32(HttpContext.Request.Cookies["StudyMate"]);
            int course_id = (int)data.courseId;
            int ans = (from c in context.courses
                       where c.Author_id == user_id
                       where c.Course_id == course_id
                       select c).Count();
            if (ans == 1)
            {
                return new JsonResult(new
                {
                    status = 200,
                    message = true
                });
            }
            return new JsonResult(new { status = 200, message = false });
        }
        else
        {
            return new JsonResult(new { status = 400, message = "Check owner - Cookies het han" });
        }
    }

    [Route("insert-payment"), HttpPost]
    public static async Task InsertPayment(int user_id, int receiver_id, int amount, int enrollment_id)
    {
        using (var context = new DBContext())
        {
            await context.payments.AddAsync(new Payment
            {
                User_id = user_id,
                Receiver_id = receiver_id,
                Amount = amount,
                Enrollment_id = enrollment_id
            });
            int rows = await context.SaveChangesAsync();
            System.Console.WriteLine($"{rows} payment inserted");
        }
    }

    [Route("update-receiver-coin"), HttpPost]
    public async Task UpdateReceiverCoin(int user_id, int amount)
    {
        using (var context = new DBContext())
        {
            var receiver = await (from user in context.users where user.User_id == user_id select user).FirstOrDefaultAsync();
            if (receiver != null)
            {
                receiver.Coin += amount;
                await context.SaveChangesAsync();
                System.Console.WriteLine($"Updated receiver coin");
            }
        }
    }

    [Route("update-sender-coin"), HttpPost]
    public async Task UpdateSenderCoin(int user_id, int amount)
    {
        using (var context = new DBContext())
        {
            var sender = await (from user in context.users where user.User_id == user_id select user).FirstOrDefaultAsync();
            if (sender != null)
            {
                sender.Coin = amount;
                await context.SaveChangesAsync();
                System.Console.WriteLine($"Updated sender coin");
            }
        }
    }

    [Route("insert-enrollment"), HttpPost]
    public async Task InsertEnrollment()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);

        int user_id = (int)data.user_id;
        int course_id = (int)data.course_id;
        int admin_id = (int)data.admin_id;
        int admin_coin = (int)data.admin_coin;
        int author_id = (int)data.author_id;
        int author_coin = (int)data.author_coin;
        int user_current_coin = (int)data.user_current_coin;

        using (var context = new DBContext())
        {
            await context.enrollments.AddAsync(new Enrollment
            {
                User_id = user_id,
                Course_id = course_id,
            });
            int rows = await context.SaveChangesAsync();
            System.Console.WriteLine($"{rows} enrollment inserted");
            var enrollment = (from e in context.enrollments
                              where e.User_id == user_id
                              where e.Course_id == course_id
                              select e).FirstOrDefault();
            int enrollment_id = enrollment.Enrollment_id;
            await InsertPayment(user_id, admin_id, admin_coin, enrollment_id);
            await InsertPayment(user_id, author_id, author_coin, enrollment_id);
            await UpdateReceiverCoin(admin_id, admin_coin);
            await UpdateReceiverCoin(author_id, author_coin);
            await UpdateSenderCoin(user_id, user_current_coin);
        }
    }

    // Sub-function
    public IQueryable<Lesson> GetLesson(int chapter_id)
    {
        var context = new DBContext();
        var lesson = (from l in context.lessons
                      where l.Chapter_id == chapter_id
                      select l);
        return lesson;
    }
    public int GetNumOfLessonInChapter(int chapter_id)
    {
        var context = new DBContext();
        int result = (from l in context.lessons
                      where l.Chapter_id == chapter_id
                      select l).Count();
        return result;
    }
    [Route("get-course-detail-by-id"), HttpPost]
    public JsonResult GetCourseDetailById()
    {
        try
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
            var context = new DBContext();

            int id = (int)data.courseId;
            var course_general = (from c in context.courses
                                  join user in context.users on c.Author_id equals user.User_id
                                  where c.Course_id == id
                                  select new
                                  {
                                      course_name = c.Course_name,
                                      course_desc = c.Course_desc,
                                      course_state = c.Course_state,
                                      img = c.Img,
                                      fee = c.Fee,
                                      commission = c.Commission,
                                      author = user.User_id,
                                      fullname = user.Fullname
                                  }).FirstOrDefault();
            var course_gains = from cg in context.course_gains
                               where cg.Course_id == id
                               select new
                               {
                                   content = cg.Content
                               };
            var course_requires = from cr in context.course_requires
                                  where cr.Course_id == id
                                  select new
                                  {
                                      content = cr.Content
                                  };
            // var duration_list = (from l in context.lessons
            //                     join cc in context.course_chapters on l.Chapter_id equals cc.Course_chapter_id
            //                     where cc.Course_chapter_id == id
            //                     select l.Duration).Sum();
            // int? total_duration = duration_list.Select(x => x.Duration).Sum();
            // int? total_duration = duration_list.AsEnumerable().Sum(l => l.Duration);
            var total_duration = (from l in context.lessons
                                  join cc in context.course_chapters on l.Chapter_id equals cc.Course_chapter_id
                                  where cc.Course_chapter_id == id
                                  select l.Duration).Sum();
            var course_chapters = from cc in context.course_chapters
                                  where cc.Course_id == id
                                  select cc;
            List<object> list_learn = new List<object>();
            foreach (var chapter in course_chapters)
            {
                var less_in_chapter = GetLesson(chapter.Course_chapter_id);
                var num_of_chapter_less = GetNumOfLessonInChapter(chapter.Course_chapter_id);
                var obj = new
                {
                    chapterTitle = chapter.Chapter_name,
                    lessons = less_in_chapter,
                    numOfChapterLess = num_of_chapter_less
                };
                list_learn.Add(obj);
            }
            return new JsonResult(new
            {
                status = 200,
                course_general = course_general,
                course_gains = course_gains,
                course_requires = course_requires,
                list_learn = list_learn,
                total_duration = total_duration
            });
        }
        catch (System.Exception e)
        {
            return new JsonResult(e);
        }
    }

    // Sub-function
    public User GetUserReview(int User_id)
    {
        var context = new DBContext();
        var user_comm = (from user in context.users
                         where user.User_id == User_id
                         select user).FirstOrDefault();
        return user_comm;
    }

    [Route("get-reviews"), HttpPost]
    public JsonResult GetReviewsByCourseId()
    {
        try
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
            var context = new DBContext();

            int id = (int)data.course_id;

            var review_list = from cv in context.course_reviews
                              where cv.Course_id == id
                              select cv;
            List<object> ans = new List<object>();
            foreach (var review in review_list)
            {
                var user = GetUserReview(review.User_id);
                var obj = new
                {
                    user = user,
                    review_content = review.Content,
                    review_state = review.Course_review_state
                };
                ans.Add(obj);
            }
            return new JsonResult(new
            {
                message = ans,
                status = 200,
            });
        }
        catch (System.Exception e)
        {
            return new JsonResult(e.ToString());
        }
    }

    // CHUA HOAN THANH -> DOI CO COOKIES
    [Route("add-course-review"), HttpPost]
    public JsonResult AddCourseReview()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);
            var context = new DBContext();

            int user_id = Convert.ToInt32(HttpContext.Request.Cookies["StudyMate"]);
            int course_id = (int)data.course_id;
            int review_state = (int)data.state;
            string content = (string)data.content;

            MySqlConnection conn = context.GetConnection();
            string str = $"insert into COURSE_REVIEWS values ({user_id},{course_id},{review_state},{content})";
            MySqlCommand cmd = new MySqlCommand(str, conn);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            return new JsonResult(new { status = 200, message = "Danh gia khoa hoc thanh cong" });
        }
        else
        {
            return new JsonResult(new { status = 400, message = "Cookies het han" });
        }
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
