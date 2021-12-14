using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Lessons")]

    public class Lesson
    {
        [Key]
        public int Lesson_id { get; set; }
        public string? Lesson_name { get; set; }
        public string? Lesson_url { get; set; }
        public int? Duration { get; set; }
        public int Chapter_id { get; set; }
    }
}