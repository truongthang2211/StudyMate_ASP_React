using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Comments")]

    public class Comment
    {
        [Key]
        public int Comment_id { get; set; }
        public int User_id { get; set; }
        public int Lesson_id { get; set; }
        public string? Content { get; set; }
        public int? Parent_comment_id { get; set; }
        public DateTime? Comment_time { get; set; }

        public Comment(int comment_id, int user_id, int lesson_id, string content, int parent_comment_id, DateTime comment_time)
        {
            Comment_id = comment_id;
            User_id = user_id;
            Lesson_id = lesson_id;
            Content = content;
            Parent_comment_id = parent_comment_id;
            Comment_time = comment_time;
        }

        public Comment()
        {
        }
    }
}