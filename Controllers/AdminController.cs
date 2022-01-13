using System.Text.Json;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MongoDB.Bson;
using MongoDB.Driver;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
[EnableCors("AllowSetOrigins")]
public class AdminController : ControllerBase
{
    [Route("get-list-course"), HttpGet]
    public JsonResult CourseList()
    {
        var context = new DBContext();
        var products = from c in context.courses select c;
        List<Course> courses = new List<Course>(products);
        List<object> ans = new List<object>();
        foreach (var product in courses)
        {
            var Author2 = (from a in context.users where a.User_id == product.Author_id select a).FirstOrDefault();
            var courseType = (from c in context.course_subtypes where c.Course_subtype_id == product.Course_type_id select c).FirstOrDefault();
            var ob = new
            {
                courseid = product.Course_id,
                coursetitle = product.Course_name,
                fee = product.Fee,
                coursestate = product.Course_state,
                commission = product.Commission,
                coursetype = courseType.Type_name,
                coursecreate = product.Created_at,
                author = new
                {
                    userid = Author2.User_id,
                    fullname = Author2.Fullname
                }

            };
            ans.Add(ob);
        }
        return new JsonResult(new
        {
            status = 200,
            message = ans
        });
    }
    [Route("get-list-user"), HttpGet]
    public JsonResult GetUsers()
    {
        var context = new DBContext();
        var users = from c in context.users select c;

        return new JsonResult(new
        {
            status = 200,
            message = users
        });
    }
    [Route("get-overview-admin"), HttpGet]
    public JsonResult Overview()
    {
        var context = new DBContext();

        if (HttpContext.Request.Cookies["StudyMateAdmin"] != null)
        {
            string id = HttpContext.Request.Cookies["StudyMate"];
            var conn = context.GetConnection();

            conn.Open();
            string sqlUserToDay = "SELECT COUNT(*) FROM ACCOUNTS WHERE DATE(CREATED_AT)=CURRENT_DATE";
            string sqlUserYesterday = "SELECT COUNT(*) FROM ACCOUNTS WHERE DATE(CREATED_AT)=SUBDATE(CURRENT_DATE(),1)";
            string sqlRevenueToDay = $@"SELECT IFNULL(SUM(AMOUNT),0) 
            FROM ENROLLMENTS E JOIN PAYMENTS P ON E.ENROLLMENT_ID = P.ENROLLMENT_ID 
            WHERE DATE(ENROLL_TIME)=CURRENT_DATE AND RECEIVER_ID=1111";
            string sqlRevenueYesterday = $@"SELECT IFNULL(SUM(AMOUNT),0) 
            FROM ENROLLMENTS E JOIN PAYMENTS P ON E.ENROLLMENT_ID = P.ENROLLMENT_ID 
            WHERE DATE(ENROLL_TIME)=SUBDATE(CURRENT_DATE(),1) AND RECEIVER_ID=1111";
            string sqlTotalRevenue = $"SELECT IFNULL(SUM(AMOUNT),0) FROM PAYMENTS WHERE RECEIVER_ID=1111";
            string sqltopCourse = @"SELECT C.COURSE_ID , c.COURSE_NAME, IFNULL(registered,0) as registered
                FROM COURSES C 
                LEFT JOIN (SELECT COURSE_ID, COUNT(*) as registered
                          FROM enrollments 
                          GROUP BY enrollments.COURSE_ID) a on c.COURSE_ID = a.Course_ID
                ORDER BY registered DESC
                LIMIT 5";
            string sqltopUser = @"SELECT USERS.USER_ID,USERS.FULLNAME,IFNULL(voted,0) cmt,IFNULL(baihoc,0) baihoc,IFNULL(khoahoc,0) khoahoc, (IFNULL(voted,0)+IFNULL(baihoc,0)*2+IFNULL(khoahoc,0)*3) total
                FROM USERS
                LEFT JOIN (
                    SELECT COMMENTS.USER_ID, COUNT(*) as voted
                    FROM COMMENTS JOIN (SELECT COMMENT_ID
                                               FROM COMMENT_VOTES
                                            WHERE COMMENT_VOTE_STATE = 1) as B ON COMMENTS.COMMENT_ID = B.COMMENT_ID
                    GROUP BY USER_ID
                ) as C ON USERS.USER_ID=C.USER_ID
                LEFT JOIN (SELECT c.AUTHOR_ID,COUNT(*) baihoc
                     FROM courses c join course_chapters cc on c.COURSE_ID = cc.COURSE_ID join lessons ls on ls.CHAPTER_ID = cc.COURSE_CHAPTER_ID
                     GROUP BY c.AUTHOR_ID) X on X.AUTHOR_ID = USERS.USER_ID
                LEFT JOIN (SELECT COUNT(*) khoahoc,c.AUTHOR_ID
                          FROM course_reviews cr join courses c on cr.COURSE_ID = c.COURSE_ID
                          WHERE cr.COURSE_REVIEW_STATE=1
                          GROUP BY c.AUTHOR_ID) Y on Y.AUTHOR_ID = users.USER_ID
                ORDER BY total DESC
                LIMIT 5";
            var reader = new MySqlCommand(sqlUserToDay, conn).ExecuteReader();
            reader.Read();
            string UserToDay = reader[0].ToString();
            conn.Close();

            conn.Open();
            reader = new MySqlCommand(sqlUserYesterday, conn).ExecuteReader();
            reader.Read();
            string UserYesterday = reader[0].ToString();

            conn.Close();
            conn.Open();
            reader = new MySqlCommand(sqlRevenueToDay, conn).ExecuteReader();
            reader.Read();
            string RevenueToDay = reader[0].ToString();

            conn.Close();
            conn.Open();
            reader = new MySqlCommand(sqlRevenueYesterday, conn).ExecuteReader();
            reader.Read();
            string RevenueYesterday = reader[0].ToString();

            conn.Close();
            conn.Open();
            reader = new MySqlCommand(sqlTotalRevenue, conn).ExecuteReader();
            reader.Read();
            string TotalRevenue = reader[0].ToString();

            conn.Close();
            conn.Open();

            var listTopCourse = new List<object>();
            reader = new MySqlCommand(sqltopCourse, conn).ExecuteReader();
            while (reader.Read())
            {
                listTopCourse.Add(new
                {
                    course_id = reader[0].ToString(),
                    course_name = reader[1].ToString(),
                    registered = reader[2].ToString()
                });
            }

            conn.Close();
            conn.Open();
            var listTopUser = new List<object>();
            reader = new MySqlCommand(sqltopUser, conn).ExecuteReader();
            while (reader.Read())
            {
                listTopUser.Add(new
                {
                    user_id = reader[0].ToString(),
                    fullname = reader[1].ToString(),
                    cmt = reader[2].ToString(),
                    baihoc = reader[3].ToString(),
                    khoahoc = reader[4].ToString(),
                    total = reader[5].ToString(),
                });
            }
            var courselist = from c in context.courses select c;
            var payments = from p in context.payments join e in context.enrollments on p.Enrollment_id equals e.Enrollment_id select e.Enroll_time;
            var accounts = from a in context.accounts select a;
            var ans = new
            {
                UserToDay = UserToDay,
                UserYesterDay = UserYesterday,
                RevenueToDay = RevenueToDay,
                RevenueYesterDay = RevenueYesterday,
                TotalRevenue = TotalRevenue,
                topCourse = listTopCourse,
                topUser = listTopUser,
                Courses = courselist,
                payments = payments,
                accounts = accounts,
            };
            conn.Close();
            return new JsonResult(new
            {
                status = 200,
                message = ans
            });
        }
        return new JsonResult(new
        {
            status = 200,
            message = "Cookies het han",
            users = HttpContext.Request.Cookies
        });

    }
    [Route("get-course"), HttpPost]

    public JsonResult GetCourseByID()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);

        string course_id = (string)data.course_id;
        DBContext context = new DBContext();
        var course = (from c in context.courses where c.Course_id.ToString() == course_id select c).FirstOrDefault();
        var main_type = (from m in context.course_subtypes where m.Course_subtype_id == course.Course_type_id select m.Parent_type_id).FirstOrDefault();
        var list_in = from l in context.course_requires where l.Course_id.ToString() == course_id select l;
        var list_out = from l in context.course_gains where l.Course_id.ToString() == course_id select l;
        var list_chapter = from l in context.course_chapters where l.Course_id.ToString() == course_id select l;
        var list_chapter_2 = new List<Course_Chapter>(list_chapter);
        var list_course = new List<System.Dynamic.ExpandoObject>();
        foreach (var chapter in list_chapter_2)
        {
            var list_lesson = from l in context.lessons where l.Chapter_id == chapter.Course_chapter_id select l;
            var list_lesson_2 = new List<Lesson>(list_lesson);

            dynamic ob = new System.Dynamic.ExpandoObject();
            ob.title = chapter.Chapter_name;
            ob.type = "chapter";
            ob.id = chapter.Course_chapter_id;
            list_course.Add(ob);
            foreach (var lesson in list_lesson_2)
            {
                dynamic ob2 = new System.Dynamic.ExpandoObject();
                ob2.id = lesson.Lesson_id; ob2.title = lesson.Lesson_name; ob2.URL = lesson.Lesson_url; ob2.type = "lesson"; ob2.error = false ;
                list_course.Add(ob2);
            }
        }
        var listin2 = new List<System.Dynamic.ExpandoObject>();
        var listout2 = new List<System.Dynamic.ExpandoObject>();
        var listin_tem = new List<Course_Require>(list_in);
        var listout_tem = new List<Course_Gain>(list_out);
        foreach (var item in listin_tem)
        {
            dynamic t = new System.Dynamic.ExpandoObject();
            t.CONTENT = item.Content;
            listin2.Add(t);
        }
        foreach (var item in listout_tem)
        {
            dynamic t = new System.Dynamic.ExpandoObject();
            t.CONTENT = item.Content;
            listout2.Add(t);
        }
        dynamic MyDynamic = new System.Dynamic.ExpandoObject();
        MyDynamic.CourseID = course.Course_id;
        MyDynamic.Author = course.Author_id;
        MyDynamic.Category = main_type;
        MyDynamic.Description = course.Course_desc;
        MyDynamic.Price = (int)course.Fee;
        MyDynamic.Image = "/" + course.Img;
        MyDynamic.SubCategory = course.Course_type_id;
        MyDynamic.Commission = course.Commission;
        MyDynamic.ListIn = listin2;
        MyDynamic.ListOut = listout2;
        MyDynamic.ListCourse = list_course;
        MyDynamic.CourseTitle = course.Course_name;


        return new JsonResult(new
        {
            status = 200,
            message = (MyDynamic),

        });
    }
    [Route("get-list-createapp"), HttpGet]
    public JsonResult GetCreateCourseApproval()
    {
        try
        {
            var mg = new DataMongoDB();
            var db = mg.DB;
            var approval = db.GetCollection<object>("Approval").Find(x => true).ToList();
            var ans = new List<object>();
            DBContext context = new DBContext();
            foreach (dynamic app in approval)
            {
                int Author = (int)app.Author;
                int SubCategory = (int)app.SubCategory;
                var author = (from a in context.users where a.User_id == Author select a).FirstOrDefault();
                var courseType = (from c in context.course_subtypes where c.Course_subtype_id == SubCategory select c).FirstOrDefault();
                var ob = new
                {
                    _id = app._id.ToString(),
                    coursetitle = app.CourseTitle,
                    fee = app.Price,
                    coursestate = app.State,
                    commission = app.Commission,
                    coursecreate = app.Created_at,
                    actiontype = app.ActionType,
                    coursetype = courseType.Type_name,
                    author = new
                    {
                        userid = author.User_id,
                        fullname = author.Fullname,
                    }
                };
                ans.Add(ob);
            }

            return new JsonResult(new
            {
                status = 200,
                message = ans,

            });
        }
        catch (Exception e)
        {

            return new JsonResult(new
            {
                status = 200,
                message = e.ToString(),

            });
        }


    }
    [Route("get-learn-app"), HttpPost]
    public JsonResult GetLearningAppById()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);



        var mg = new DataMongoDB();
        var db = mg.DB;
        var course_id = (string)data.course_id;
        var filter = Builders<object>.Filter.Eq("_id", new ObjectId(course_id));
        dynamic approval = db.GetCollection<object>("Approval").Find(filter).FirstOrDefault();
        var ListLearn = new List<object>();
        foreach (var chapter in approval.ListCourse)
        {
            var lessoninchapter = new List<object>();
            foreach (var lesson in chapter.lesson)
            {
                var ob2 = new
                {
                    lesson_id = (object)null,
                    lesson_name = lesson.title,
                    lesson_url = lesson.url,
                    duration = lesson.duration,

                };
                lessoninchapter.Add(ob2);
            }
            var ob = new
            {
                chaptertitle = chapter.title,
                lesson = lessoninchapter,
            };
            ListLearn.Add(ob);
        }
        var ans = new
        {
            coursetitle = approval.CourseTitle,
            listlearn = ListLearn,
            laslessonlearnt = -1,
            learningurl = approval.ListCourse[0].lesson[0].url,
            author = approval.Author,

        };
        return new JsonResult(new
        {
            status = 200,
            message = ans,

        });
    }
    [Route("lock-course-action"), HttpPost]
    public JsonResult LockCourseAction()
    {
        try
        {
            var reader = new StreamReader(HttpContext.Request.Body);
            var body = reader.ReadToEnd();
            dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
            DBContext context = new DBContext();
            int course_id = (int)data.course_id;
            var course = (from c in context.courses where c.Course_id == course_id select c).FirstOrDefault();
            var noti = new Notification();
            noti.Created_at = DateTime.Now;
            noti.User_id = course.Author_id;
            noti.Read_state = false;
            if (course.Course_state == "Công khai")
            {
                course.Course_state = "Bị khóa";
                string reason = (string)data.reason;
                noti.Content = "Khóa học " + course.Course_name + " đã bị khóa với lý do: " + reason;
            }
            else if (course.Course_state == "Bị khóa")
            {
                course.Course_state = "Công khai";
                noti.Content = "Khóa học " + course.Course_name + " đã được mở khóa: ";
            }
            context.Update(course);
            context.Add(noti);
            context.SaveChanges();
            return new JsonResult(new
            {
                status = 200,
                message = "Thành công",

            });
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
    [Route("login"), HttpPost]
    public JsonResult AdminLogin()
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
        if ((Account != null || User != null) && Account.Account_role == "Admin")
        {
            if (BCrypt.Net.BCrypt.Verify(passw, Account.Pwd))
            {
                Set("StudyMateAdmin", ID.ToString(), 60 * 24);

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
            message = "Email hoặc username không hợp lệ";
        }
        return new JsonResult(new
        {
            status = statuscode,
            message = message,
            id = ID.ToString()
        });
    }
    [Route("get-user-admin"), HttpGet]
    public object GetCurrentUser()
    {
        if (HttpContext.Request.Cookies["StudyMateAdmin"] != null)
        {
            string id = HttpContext.Request.Cookies["StudyMateAdmin"];
            DBContext context = new DBContext();
            User user = (from u in context.users where u.User_id.ToString() == id select u).FirstOrDefault();
            return (new { status = 200, message = "Lay User thanh cong", user = user });
        }
        else
        {
            return new JsonResult(new
            {
                status = 200,
                message = "Cookies het han",
                users = HttpContext.Request.Cookies
            });
        }
    }

    [Route("get-list-approvaled"), HttpGet]
    public JsonResult GetApprovaled()
    {
        DBContext context = new DBContext();
        var ans = from a in context.approvals select a;
        return new JsonResult(new
        {
            status = 200,
            message = ans,
        });
    }
    [Route("get-user"), HttpPost]
    public JsonResult GetUserByID()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
        string user_id = (string)data.user_id;
        DBContext context = new DBContext();
        var ans = (from a in context.users where a.User_id.ToString() == user_id select a).FirstOrDefault();
        return new JsonResult(new
        {
            status = 200,
            message = ans,
        });
    }
    public string? Get(string key)
    {
        return Request.Cookies[key];
    }

    public void Set(string key, string value, int? expireTime)
    {
        CookieOptions cookieOptions = new CookieOptions();
        cookieOptions.Expires = new DateTimeOffset(DateTime.Now.AddDays(7));
        HttpContext.Response.Cookies.Append(key, value, cookieOptions);
    }

    public void Remove(string key)
    {
        Response.Cookies.Delete(key);
    }
}
