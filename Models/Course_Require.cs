using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Course_Requires")]

    public class Course_Require
    {
        [Key]
        public int Course_require_id { get; set; }
        public string? Content { get; set; }
        public int Course_id { get; set; }
        
    }
}