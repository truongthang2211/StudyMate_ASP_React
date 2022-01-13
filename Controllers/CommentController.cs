using System.Text.Json;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using StudyMate_ASP_React.Models;

namespace StudyMate_ASP_React.Controllers;

[ApiController]
[Route("[controller]")]
[EnableCors("AllowSetOrigins")]
public class CommentController : ControllerBase
{
    [Route("get-comments"), HttpPost]
    public JsonResult GetListCommentByLesson()
    {
        var reader = new StreamReader(HttpContext.Request.Body);
        var body = reader.ReadToEnd();
        dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
        string lesson_id = (string)data.lesson_id;
        DBContext context = new DBContext();
        var commentList = from c in context.comment where c.Lesson_id.ToString() == lesson_id && c.Parent_comment_id == null select c;
        var commentList_2 = new List<Comment>(commentList);
        var ans = new List<object>();
        foreach (var cmt in commentList_2)
        {
            var user = (from u in context.users where u.User_id == cmt.User_id select u).FirstOrDefault();
            var subcomments = from scmt in context.comment where scmt.Parent_comment_id == cmt.Comment_id select scmt;
            var subcomments_2 = new List<Comment>(subcomments);
            // var users_voted = from cmtv in context.comment_votes where cmtv.Comment_id==cmt.Comment_id select cmtv.User_id;
            var ans2 = new List<object>();
            foreach (var subcmt in subcomments_2)
            {
                var sub_user = (from u in context.users where u.User_id == subcmt.User_id select u).FirstOrDefault();
                // var users_sub_voted = from cmtv in context.comment_votes where cmtv.Comment_id==subcmt.Comment_id select cmtv.User_id;
                var ob = new
                {
                    commentid = subcmt.Comment_id,
                    user = sub_user,
                    content = subcmt.Content,
                    parentcomment = subcmt.Parent_comment_id,
                    commenttime = subcmt.Comment_time.ToString(),
                    usersvoted = from cmtv in context.comment_votes where cmtv.Comment_id == subcmt.Comment_id select cmtv
                };
                ans2.Add(ob);
            }
            var ob2 = new
            {
                commentid = cmt.Comment_id,
                user = user,
                content = cmt.Content,
                parentcomment = cmt.Parent_comment_id,
                commenttime = cmt.Comment_time.ToString(),
                subcomments = ans2,
                usersvoted = from cmtv in context.comment_votes where cmtv.Comment_id == cmt.Comment_id select cmtv
            };
            ans.Add(ob2);
        }
        return new JsonResult(new
        {
            status = 200,
            message = ans
        });
    }
    [EnableCors("AllowSetOrigins")]
    [Route("add-comment"), HttpPost]
    public JsonResult AddComment()
    {
        try
        {
            if (HttpContext.Request.Cookies["StudyMateAdmin"] != null)
            {
                string id = HttpContext.Request.Cookies["StudyMate"];
                var reader = new StreamReader(HttpContext.Request.Body);
                var body = reader.ReadToEnd();
                dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
                var comment = new Comment();
                comment.Comment_time = DateTime.Now;
                comment.User_id = Int32.Parse(id);
                comment.Lesson_id = (int)data.lesson_id;
                comment.Content = (string)data.content;
                comment.Parent_comment_id = (int?)data.parent_comment_id;
                DBContext context = new DBContext();
                context.comment.Add(comment);
                context.SaveChanges();
                return new JsonResult(new
                {
                    status = 200,
                    message = "Thêm comment thành công"
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
                status = 200,
                message = e.ToString(),
            });
        }


    }
    [Route("comment-vote"), HttpPost]
    public JsonResult VoteComment()
    {
        try
        {
            if (HttpContext.Request.Cookies["StudyMateAdmin"] != null)
            {
                string id = HttpContext.Request.Cookies["StudyMate"];
                var reader = new StreamReader(HttpContext.Request.Body);
                var body = reader.ReadToEnd();
                dynamic? data = JsonConvert.DeserializeObject<System.Dynamic.ExpandoObject>(body);
                int comment_id = (int)data.comment_id;
                DBContext context = new DBContext();
                var cmt = (from cmtv in context.comment_votes where cmtv.Comment_id == comment_id where cmtv.User_id.ToString() == id select cmtv).FirstOrDefault();
                if ((int)data.comment_state == -1)
                {
                    string sql = $"DELETE FROM COMMENT_VOTES WHERE USER_ID={id} AND COMMENT_ID={comment_id}";
                    var conn = context.GetConnection();
                    conn.Open();
                    var cmd = new MySqlCommand(sql, conn);

                    cmd.ExecuteNonQuery();
                    conn.Close();

                }
                else
                {
                    if (cmt == null)
                    {
                        cmt = new Comment_Vote();
                        cmt.User_id = Int32.Parse(id);
                        cmt.Comment_id = (int)data.comment_id;
                        cmt.Comment_vote_state = Convert.ToBoolean((int)data.comment_state);
                        context.comment_votes.Add(cmt);
                    }
                    else
                    {
                        string state = Convert.ToBoolean((int)data.comment_state)?"true":"false";
                        string sql = $"update COMMENT_VOTES SET COMMENT_VOTE_STATE={state} WHERE USER_ID={id} AND COMMENT_ID={comment_id}";
                        var conn = context.GetConnection();
                        conn.Open();
                        var cmd = new MySqlCommand(sql, conn);

                        cmd.ExecuteNonQuery();
                        conn.Close();

                    }
                }
                context.SaveChanges();
                return new JsonResult(new
                {
                    status = 200,
                    message = "thành công"
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
                status = 200,
                message = e.ToString(),
            });
        }


    }
}



