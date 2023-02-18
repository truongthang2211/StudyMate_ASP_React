using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Course_Chapters")]

    public class Course_Chapter
    {
        [Key]
        public int Course_chapter_id { get; set; }
        public string? Chapter_name { get; set; }
        public int Course_id { get; set; }
        
    }
}