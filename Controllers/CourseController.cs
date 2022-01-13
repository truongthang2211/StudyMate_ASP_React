using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;
using System.Collections;
using Microsoft.AspNetCore.Cors;
using MySql.Data.MySqlClient;
using MongoDB.Driver;
using System.Net.Http.Headers;
using MongoDB.Bson;

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

    [Route("add-review"), HttpPost]
    public async Task AddCourseReview()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<dynamic>(body);

            int user_id = Convert.ToInt32(HttpContext.Request.Cookies["StudyMate"]);
            int course_id = (int)data.course_id;
            int review_state = (int)data.state;
            string content = (string)data.content;

            // MySqlConnection conn = context.GetConnection();
            // string str = $"insert into COURSE_REVIEWS values ({user_id},{course_id},{review_state},{content})";
            // MySqlCommand cmd = new MySqlCommand(str, conn);
            // conn.Open();
            // cmd.ExecuteNonQuery();
            // conn.Close();

            using (var context = new DBContext())
            {
                await context.course_reviews.AddAsync(new Course_Review
                {
                    User_id = user_id,
                    Course_id = course_id,
                    Course_review_state = review_state,
                    Content = content
                });
                int rows = await context.SaveChangesAsync();
                System.Console.WriteLine($"{rows} course_review inserted");
            }
        }
        else
        {
            System.Console.WriteLine($"Insert course_review unsuccessfully");
        }
    }

    [Route("action-course"), HttpPost]
    public JsonResult CreateorDelCourse()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
        var mg = new DataMongoDB();
        var db = mg.DB;
        var course_id = (string)data._id;
        bool accept = (bool)data.accept;
        var filter = Builders<object>.Filter.Eq("_id", new ObjectId(course_id));
        dynamic approval = db.GetCollection<object>("Approval").Find(filter).FirstOrDefault();
        DBContext context = new DBContext();
        var transaction = context.Database.BeginTransaction();
        try
        {
            var course = new Course();
            course.Course_name = approval.CourseTitle;
            course.Fee = approval.Price;
            course.Img = approval.Image;
            course.Course_desc = approval.Description;
            course.Course_state = "Công khai";
            if (!accept)
            {
                course.Course_state = "Từ chối";
            }
            course.Commission = approval.Commission;
            course.Author_id = (int)approval.Author;
            course.Course_type_id = (int)approval.SubCategory;
            //
            context.courses.Add(course);
            context.SaveChanges();
            context.Entry(course).GetDatabaseValues();


            foreach (var item in approval.ListIn)
            {
                var course_re = new Course_Require();
                course_re.Content = item.CONTENT;
                course_re.Course_id = course.Course_id;
                context.course_requires.Add(course_re);
            }
            foreach (var item in approval.ListOut)
            {
                var course_ga = new Course_Gain();
                course_ga.Content = item.CONTENT;
                course_ga.Course_id = course.Course_id;
                context.course_gains.Add(course_ga);
            }
            foreach (var item in approval.ListCourse)
            {
                var course_chapter = new Course_Chapter();
                course_chapter.Chapter_name = item.title;
                course_chapter.Course_id = course.Course_id;
                context.course_chapters.Add(course_chapter);
                context.SaveChanges();
                context.Entry(course_chapter).GetDatabaseValues();
                foreach (var item2 in item.lesson)
                {
                    var lesson = new Lesson();
                    lesson.Lesson_name = item2.title;
                    lesson.Lesson_url = item2.url;
                    lesson.Duration = (int)item2.duration;
                    lesson.Chapter_id = course_chapter.Course_chapter_id;
                    context.lessons.Add(lesson);
                }
            }
            var noti = new Notification();
            noti.User_id = (int)approval.Author;
            noti.Read_state = false;
            var app = new Approval();
            app.Course_id = course.Course_id;
            app.Accept = accept;
            if (!accept)
            {
                string reason = (string)data.reason;
                app.Reason = reason;
                noti.Content = "Khóa học " + approval.CourseTitle + " đã bị từ chối với lý do: " + reason;

            }
            else
            {
                noti.Content = "Chúc mừng khóa học " + approval.CourseTitle + " của bạn đã được duyệt";
            }
            context.approvals.Add(app);
            context.notifications.Add(noti);
            context.SaveChanges();
            transaction.Commit();
            db.GetCollection<object>("Approval").DeleteOne(filter);
            return new JsonResult(new
            {
                status = 200,
                message = "thành công",

            });
        }
        catch (System.Exception e)
        {
            transaction.Rollback();
            return new JsonResult(new
            {
                status = 400,
                message = e.ToString(),

            });
        }

    }
    [Route("update-course"), HttpPost]
    public JsonResult UpdateCourse([FromForm] string data)
    {

        dynamic? data2 = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(data);

        DBContext context = new DBContext();
        var transaction = context.Database.BeginTransaction();
        try
        {
            int course_id = (int)data2.CourseID;
            var course = (from c in context.courses where c.Course_id == course_id select c).FirstOrDefault();
            course.Course_name = data2.CourseTitle;
            course.Fee = data2.Price;
            if (HttpContext.Request.Form.Files.Count() > 0)
            {
                var file = HttpContext.Request.Form.Files[0];
                var path = Directory.GetCurrentDirectory() + @"\ClientApp\public\";
                var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                var FileExtension = Path.GetExtension(fileName);


                var newFileName = @"img/course/" + ((int)(DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds).ToString() + FileExtension;
                var PathDB = path + newFileName;
                course.Img = newFileName;
                using (FileStream fs = System.IO.File.Create(PathDB))
                {
                    file.CopyTo(fs);
                    fs.Flush();
                }
            }
            course.Course_desc = data2.Description;
            course.Course_state = "Công khai";
            course.Commission = data2.Commission;
            course.Author_id = (int)data2.Author;
            course.Course_type_id = (int)data2.SubCategory;
            //
            context.courses.Update(course);
            context.SaveChanges();
            context.Entry(course).GetDatabaseValues();


            foreach (var item in data2.ListIn)
            {
                var course_re = new Course_Require();
                course_re.Content = item.CONTENT;
                course_re.Course_id = course.Course_id;
                context.course_requires.Add(course_re);
            }
            foreach (var item in data2.ListOut)
            {
                var course_ga = new Course_Gain();
                course_ga.Content = item.CONTENT;
                course_ga.Course_id = course.Course_id;
                context.course_gains.Add(course_ga);
            }
            foreach (var item in data2.ListCourse)
            {
                var course_chapter = new Course_Chapter();
                if (item.id != null)
                {
                    int course_chapter_id = (int)item.id;
                    course_chapter = (from c in context.course_chapters where c.Course_chapter_id == course_chapter_id select c).FirstOrDefault();
                }
                course_chapter.Chapter_name = item.title;
                course_chapter.Course_id = course.Course_id;
                if (item.id != null)
                {
                    context.course_chapters.Update(course_chapter);

                }
                else
                {
                    context.course_chapters.Add(course_chapter);

                }
                context.SaveChanges();
                context.Entry(course_chapter).GetDatabaseValues();
                foreach (var item2 in item.lesson)
                {
                    var lesson = new Lesson();
                    if (item2.id != null)
                    {
                        int lesson_id = (int)item2.id;
                        lesson = (from c in context.lessons where c.Lesson_id == lesson_id select c).FirstOrDefault();
                    }
                    lesson.Lesson_name = item2.title;
                    lesson.Lesson_url = item2.url;
                    lesson.Duration = (int)item2.duration;
                    lesson.Chapter_id = course_chapter.Course_chapter_id;
                    if (item2.id != null)
                    {
                        context.lessons.Update(lesson);

                    }
                    else
                    {
                        context.lessons.Add(lesson);

                    }
                }
            }

            context.SaveChanges();
            transaction.Commit();
            return new JsonResult(new
            {
                status = 200,
                message = "thành công",

            });
        }
        catch (System.Exception e)
        {
            transaction.Rollback();
            return new JsonResult(new
            {
                status = 400,
                message = e.ToString(),
                test = data2,
            });
        }

    }
    [Route("update-course-app"), HttpPost]
    public JsonResult UpdateCourseApp()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
        var mg = new DataMongoDB();
        var db = mg.DB;
        var course_id = (string)data._id;
        bool accept = (bool)data.accept;
        var filter = Builders<object>.Filter.Eq("_id", new ObjectId(course_id));
        dynamic approval = db.GetCollection<object>("Approval").Find(filter).FirstOrDefault();
        DBContext context = new DBContext();
        var transaction = context.Database.BeginTransaction();
        try
        {
            int course_id_app = (int)approval.CourseID;
            var course = (from c in context.courses where c.Course_id == course_id_app select c).FirstOrDefault();
            course.Course_name = approval.CourseTitle;
            course.Fee = approval.Price;
            course.Img = approval.Image;
            course.Course_desc = approval.Description;
            course.Course_state = "Công khai";
            course.Commission = approval.Commission;
            course.Author_id = (int)approval.Author;
            course.Course_type_id = (int)approval.SubCategory;
            //
            context.courses.Update(course);
            context.SaveChanges();
            context.Entry(course).GetDatabaseValues();
            var c_re = (from c in context.course_requires where c.Course_id == course_id_app select c).ToList();
            context.course_requires.RemoveRange(c_re);
            var c_ga = (from c in context.course_gains where c.Course_id == course_id_app select c).ToList();
            context.course_gains.RemoveRange(c_ga);
            foreach (var item in approval.ListIn)
            {
                var course_re = new Course_Require();
                course_re.Content = item.CONTENT;
                course_re.Course_id = course.Course_id;
                context.course_requires.Add(course_re);
            }
            foreach (var item in approval.ListOut)
            {
                var course_ga = new Course_Gain();
                course_ga.Content = item.CONTENT;
                course_ga.Course_id = course.Course_id;
                context.course_gains.Add(course_ga);
            }
            foreach (var item in approval.ListCourse)
            {
                var course_chapter = new Course_Chapter();
                if (item.id != null)
                {
                    int course_chapter_id = (int)item.id;
                    course_chapter = (from c in context.course_chapters where c.Course_chapter_id == course_chapter_id select c).FirstOrDefault();
                }
                course_chapter.Chapter_name = item.title;
                course_chapter.Course_id = course.Course_id;
                if (item.id != null)
                {
                    context.course_chapters.Update(course_chapter);

                }
                else
                {
                    context.course_chapters.Add(course_chapter);

                }
                context.SaveChanges();
                context.Entry(course_chapter).GetDatabaseValues();
                foreach (var item2 in item.lesson)
                {
                    var lesson = new Lesson();
                    if (item2.id != null)
                    {
                        int lesson_id = (int)item2.id;
                        lesson = (from c in context.lessons where c.Lesson_id == lesson_id select c).FirstOrDefault();
                    }
                    lesson.Lesson_name = item2.title;
                    lesson.Lesson_url = item2.url;
                    lesson.Duration = (int)item2.duration;
                    lesson.Chapter_id = course_chapter.Course_chapter_id;
                    if (item2.id != null)
                    {
                        context.lessons.Update(lesson);

                    }
                    else
                    {
                        context.lessons.Add(lesson);

                    }
                }
            }
            var noti = new Notification();
            noti.User_id = (int)approval.Author;
            noti.Read_state = false;
            var app = new Approval();
            app.Course_id = course.Course_id;
            app.Accept = accept;
            if (!accept)
            {
                string reason = (string)data.reason;
                app.Reason = reason;
                noti.Content = "Khóa học " + approval.CourseTitle + " đã bị từ chối với lý do: " + reason;

            }
            else
            {
                noti.Content = "Chúc mừng yêu cầu chỉnh sửa khóa học " + approval.CourseTitle + " của bạn đã được duyệt";
            }
            context.approvals.Add(app);
            context.notifications.Add(noti);
            context.SaveChanges();
            transaction.Commit();
            db.GetCollection<object>("Approval").DeleteOne(filter);
            return new JsonResult(new
            {
                status = 200,
                message = "thành công",

            });
        }
        catch (System.Exception e)
        {
            transaction.Rollback();
            return new JsonResult(new
            {
                status = 400,
                message = e.ToString(),

            });
        }

    }
    [Route("get-learn/{course_id}/{lesson_id}"), HttpGet]
    public JsonResult GetLearning(string course_id, string lesson_id)
    {

        DBContext context = new DBContext();
        try
        {
            if (HttpContext.Request.Cookies["StudyMate"] != null)
            {
                string id = HttpContext.Request.Cookies["StudyMate"];
                var enroll = (from e in context.enrollments where e.User_id.ToString() == id where e.Course_id.ToString() == course_id select e).FirstOrDefault();
                var this_course = (from c in context.courses where c.Course_id.ToString() == course_id select c).FirstOrDefault();
                if (enroll == null && id != this_course.Author_id.ToString())
                {
                    return new JsonResult(new
                    {
                        status = 201,
                    });
                }
                var courseType = (from c in context.course_subtypes where c.Course_subtype_id == this_course.Course_type_id select c).FirstOrDefault();
                var courseMainType = (from c in context.course_maintypes where c.Course_maintype_id == courseType.Parent_type_id select c).FirstOrDefault();
                var chapters = from ch in context.course_chapters where ch.Course_id.ToString() == course_id select ch;

                var temp_lesson = from l in context.lessons where (from c in chapters select c.Course_chapter_id).Contains(l.Chapter_id) select l;
                var temp_lesson_list = (from tl in temp_lesson select tl.Lesson_id).ToArray();
                var lesson = (from l in context.learnings where temp_lesson_list.Contains(l.Lesson_id) where l.User_id.ToString() == id select l.Lesson_id).DefaultIfEmpty().Max();
                var firstLesson = (from l in context.lessons where l.Chapter_id == (from c in chapters select c.Course_chapter_id).Min() select l.Lesson_id).Min();
                if (lesson_id == "undefined" || Int32.Parse(lesson_id) > lesson)
                {
                    lesson_id = lesson != 0 ? lesson.ToString() : firstLesson.ToString();
                }
                lesson = lesson != 0 ? lesson : -1;
                var ListLearn = new List<object>();
                List<Course_Chapter> list_chapters = new List<Course_Chapter>(chapters);
                foreach (var item in list_chapters)
                {
                    var lessoninchapter = from l in context.lessons where l.Chapter_id == item.Course_chapter_id select l;
                    var ob = new
                    {
                        chaptertitle = item.Chapter_name,
                        lesson = lessoninchapter,
                    };
                    ListLearn.Add(ob);
                }
                var ans = new
                {
                    coursetitle = this_course.Course_name,
                    listlearn = ListLearn,
                    lastlessonlearnt = lesson,
                    learningurl = (from l in context.lessons where l.Lesson_id.ToString() == lesson_id select l.Lesson_url).FirstOrDefault(),
                    author = (from c in context.courses where c.Course_id.ToString() == course_id select c.Author_id).FirstOrDefault(),
                    coursetype = courseType,
                    coursemaintype = courseMainType,
                };
                return new JsonResult(new
                {
                    status = 200,
                    message = ans,

                });
            }
            else
            {
                return new JsonResult(new
                {
                    status = 200,
                    message = "Cookies het han",
                });
            }

        }
        catch (System.Exception e)
        {
            return new JsonResult(new
            {
                status = 400,
                message = e.ToString(),

            });
        }
    }
    [Route("add-learn"), HttpPost]
    public JsonResult AddLearn()
    {

        DBContext context = new DBContext();
        try
        {
            if (HttpContext.Request.Cookies["StudyMate"] != null)
            {
                string id = HttpContext.Request.Cookies["StudyMate"];
                var reader = new StreamReader(HttpContext.Request.Body);
                var body = reader.ReadToEnd();
                dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
                int lesson_id = (int)data.lesson_id;
                var learning = (from l in context.learnings
                                where l.User_id.ToString() == id
                                where l.Lesson_id == lesson_id
                                select l).FirstOrDefault();
                if (learning == null)
                {
                    learning = new Learning();
                    learning.User_id = Int32.Parse(id);
                    learning.Lesson_id = lesson_id;
                    context.learnings.Add(learning);
                    context.SaveChanges();
                }
                return new JsonResult(new
                {
                    status = 200,
                });
            }
            else
            {
                return new JsonResult(new
                {
                    status = 200,
                    message = "Cookies het han",
                });
            }

        }
        catch (System.Exception e)
        {
            return new JsonResult(new
            {
                status = 400,
                message = e.ToString(),

            });
        }
    }
    [Route("create-course-approval"), HttpPost]
    public JsonResult AddCourseApproval([FromForm] string data)
    {

        DBContext context = new DBContext();
        try
        {
            if (HttpContext.Request.Cookies["StudyMate"] != null)
            {
                string id = HttpContext.Request.Cookies["StudyMate"];
                var mg = new DataMongoDB();
                var db = mg.DB;
                dynamic? data2 = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(data);
                if (HttpContext.Request.Form.Files.Count() > 0)
                {
                    var file = HttpContext.Request.Form.Files[0];
                    var path = Directory.GetCurrentDirectory() + @"\ClientApp\public\";
                    var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                    var FileExtension = Path.GetExtension(fileName);


                    var newFileName = @"img/course/" + ((int)(DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds).ToString() + FileExtension;
                    var PathDB = path + newFileName;
                    data2.Image = newFileName;
                    using (FileStream fs = System.IO.File.Create(PathDB))
                    {
                        file.CopyTo(fs);
                        fs.Flush();
                    }
                }

                string data_img = (string)data2.Image;
                data2.Image = data_img.TrimStart('/');
                db.GetCollection<object>("Approval").InsertOne(data2);
                return new JsonResult(new
                {
                    status = 200,
                    message = "Thành công",
                });
            }
            else
            {
                return new JsonResult(new
                {
                    status = 200,
                    message = "Cookies het han",
                });
            }

        }
        catch (System.Exception e)
        {
            return new JsonResult(new
            {
                status = 400,
                message = e.ToString(),

            });
        }
    }
    [Route("get-registered-courses"), HttpGet]
    public JsonResult GetRegisteredCourse()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            string id = HttpContext.Request.Cookies["StudyMate"];
            DBContext context = new DBContext();
            var conn = context.GetConnection();
            conn.Open();
            string sql = $@"SELECT c.*, u.FULLNAME, e.*,a.paid
                FROM enrollments e join courses c on e.COURSE_ID = c.COURSE_ID 
                join users u on u.USER_ID = c.AUTHOR_ID
                join (select ENROLLMENT_ID,sum(AMOUNT) as paid from payments group by ENROLLMENT_ID) a on a.enrollment_id = e.ENROLLMENT_ID 
                where e.USER_ID={id}";
            var cmd = new MySqlCommand(sql, conn);
            var rs = cmd.ExecuteReader();

            var ans = new List<object>();
            while (rs.Read())
            {
                int this_course_id = Int32.Parse(rs[14].ToString());
                int first_ch = (from c in context.course_chapters where c.Course_id == this_course_id select c.Course_chapter_id).Min();
                int last_ch = (from c in context.course_chapters where c.Course_id == this_course_id select c.Course_chapter_id).Max();
                int first_less = (from l in context.lessons where l.Chapter_id == first_ch select l.Lesson_id).Min();
                int last_less = (from l in context.lessons where l.Chapter_id == last_ch select l.Lesson_id).Max();
                var learning = (from l in context.learnings where l.Lesson_id >= first_less && l.Lesson_id <= last_less && l.User_id.ToString()==id select l.Lesson_id).Max();
                var ob = new
                {

                    course_name = rs[1].ToString(),
                    fee = rs[2],
                    course_desc = rs[3].ToString(),
                    img = rs[4].ToString(),
                    course_state = rs[5].ToString(),
                    commission = rs[6],
                    course_type_id = rs[7],
                    author_id = rs[8],
                    created_at = rs[9].ToString(),
                    updated_at = rs[10].ToString(),
                    fullname = rs[11].ToString(),
                    enrollment_id = rs[12],
                    user_id = rs[13],
                    course_id = rs[14],
                    enroll_time = rs[15].ToString(),
                    paid = rs[16],
                    first_less = first_less,
                    last_less = last_less,
                    learning_less = learning,
                };
                ans.Add(ob);
            }
            conn.Close();
            return new JsonResult(new
            {
                status = 200,
                message = ans,

            });
        }
        return new JsonResult(new
        {
            status = 200,
            message = "Cookies het han",

        });
    }
    [Route("get-overview"), HttpGet]
    public JsonResult GetOverview()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            string id = HttpContext.Request.Cookies["StudyMate"];
            DBContext context = new DBContext();
            var enroll = from e in context.enrollments join c in context.courses on e.Course_id equals c.Course_id where c.Author_id.ToString() == id select e;
            var payments = from p in context.payments join e in context.enrollments on p.Enrollment_id equals e.Enrollment_id where p.Receiver_id.ToString() == id select new { p.Amount, e.Enroll_time };
            var ans = new
            {
                payments = payments,
                learns = from l in context.learnings where l.User_id.ToString() == id select l,
                enrollments = enroll,
            };
            return new JsonResult(new
            {
                status = 200,
                message = ans,

            });
        }
        return new JsonResult(new
        {
            status = 200,
            message = "Cookies het han",

        });
    }
    [Route("my-course"), HttpGet]
    public JsonResult GetUserCourse()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            string id = HttpContext.Request.Cookies["StudyMate"];
            DBContext context = new DBContext();
            var course_list = from c in context.courses where c.Author_id.ToString() == id where (c.Course_state == "Công khai" || c.Course_state == "Bị khóa") select c;
            var ans = new List<object>();
            var course_list2 = new List<Course>(course_list);
            var conn = context.GetConnection();
            foreach (var course in course_list2)
            {
                var course_review = from crv in context.course_reviews where crv.Course_id == course.Course_id select crv;
                conn.Open();
                string sql = $@"SELECT IFNULL(SUM(AMOUNT),0) FROM PAYMENTS P JOIN ENROLLMENTS E ON P.ENROLLMENT_ID = E.ENROLLMENT_ID
                                WHERE RECEIVER_ID={id} AND COURSE_ID={course.Course_id}";
                var reader = new MySqlCommand(sql, conn).ExecuteReader();
                reader.Read();
                var earn = reader[0];
                conn.Close();
                var subcribe = (from e in context.enrollments where e.Course_id == course.Course_id select e).Count();

                var ob = new
                {
                    coursetitle = course.Course_name,
                    created_at = course.Created_at,
                    price = course.Fee,
                    commission = course.Commission,
                    status = course.Course_state,
                    rate = new
                    {
                        up = (from rv in course_review where rv.Course_review_state == 1 select rv).Count(),
                        down = (from rv in course_review where rv.Course_review_state == 0 select rv).Count(),
                    },
                    earn = earn,
                    subcribe = subcribe,
                    courseid = course.Course_id,
                    courseimg = course.Img
                };
                ans.Add(ob);
            }
            return new JsonResult(new
            {
                status = 200,
                message = ans,

            });
        }
        return new JsonResult(new
        {
            status = 200,
            message = "Cookies het han",

        });
    }
    [Route("my-course-app"), HttpGet]
    public JsonResult GetUserCourseApp()
    {
        if (HttpContext.Request.Cookies["StudyMate"] != null)
        {
            string id = HttpContext.Request.Cookies["StudyMate"];
            DBContext context = new DBContext();
            var mg = new DataMongoDB();
            var db = mg.DB;
            var filter = Builders<object>.Filter.Eq("Author", Int32.Parse(id));
            dynamic approval = db.GetCollection<object>("Approval").Find(filter).ToList();
            var ans = new List<object>();
            foreach (var item in approval)
            {
                int course_sub_id = (int)item.SubCategory;
                var courseType = (from c in context.course_subtypes where c.Course_subtype_id == course_sub_id select c).FirstOrDefault();
                var ob = new
                {
                    _id = item._id.ToString(),
                    coursetitle = item.CourseTitle,
                    courseimg = item.Image,
                    fee = item.Price,
                    coursestate = item.State,
                    coursecreate = item.Created_at,
                    actiontype = item.ActionType,
                    coursetype = courseType.Type_name,
                };
                ans.Add(ob);
            }
            return new JsonResult(new
            {
                status = 200,
                message = ans,

            });
        }
        return new JsonResult(new
        {
            status = 200,
            message = "Cookies het han",

        });
    }
    [Route("search-course"), HttpPost]
    public JsonResult SearchCourse()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
        DBContext context = new DBContext();
        var conn = context.GetConnection();
        conn.Open();
        string sql = $@"SELECT b.course_id,b.course_name,b.fee,b.course_desc,b.img,b.created_at,b.user_id,b.fullname, 
            IFNULL(enrolled,0) enrolled, IFNULL(upVote,0) upVote, IFNULL(downVote,0) downVote
            FROM (
                SELECT a.*,u.*
                FROM (
                    SELECT * FROM courses c WHERE c.COURSE_NAME LIKE '%{(string)data.search_data}%' and c.Course_state = 'Công khai'
                ) a join users u on a.Author_id = u.USER_ID
            ) b left join (SELECT COURSE_ID,COUNT(COURSE_ID) enrolled
                		FROM enrollments
                          GROUP BY enrollments.COURSE_ID) e on b.COURSE_ID = e.COURSE_ID left join 
            (SELECT cr.COURSE_ID,SUM(IF(cr.COURSE_REVIEW_STATE=1,1,0))
            upVote,SUM(IF(cr.COURSE_REVIEW_STATE=0,1,0)) downVote
             FROM course_reviews cr 
             GROUP BY cr.COURSE_ID) cr on cr.COURSE_ID = b.COURSE_ID
            GROUP BY b.course_id,b.course_name,b.fee,b.course_desc,b.img,b.created_at,b.user_id,b.fullname,e.enrolled, upVote,downVote";
        var cmd = new MySqlCommand(sql, conn);
        var rs = cmd.ExecuteReader();
        var ans = new List<object>();
        while (rs.Read())
        {
            var ob = new
            {
                course_id = rs[0],
                course_name = rs[1].ToString(),
                fee = rs[2],
                course_desc = rs[3].ToString(),
                img = rs[4].ToString(),
                created_at = rs[5].ToString(),
                user_id = rs[6],
                fullname = rs[7].ToString(),
                enrolled = rs[8],
                upvote = rs[9],
                downvote = rs[10]
            };
            ans.Add(ob);
        }
        conn.Close();
        return new JsonResult(new
        {
            status = 200,
            message = ans,

        });
    }
}
