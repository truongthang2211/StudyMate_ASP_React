using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Course_Reviews")]

    public class Course_Review
    {
        [Key]
        public int User_id { get; set; }
        public int Course_id { get; set; }
        public bool Course_review_state { get; set; }
        public string? Content { get; set; }
    }
}