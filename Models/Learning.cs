using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Learnings")]

    public class Learning
    {
        [Key]
        public int User_id { get; set; }
        public int Lesson_id { get; set; }
        public DateTime? Learn_time { get; set; }
    }
}