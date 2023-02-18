using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Course_Gains")]

    public class Course_Gain
    {
        [Key]
        public int Course_gain_id { get; set; }
        public string? Content { get; set; }
        public int Course_id { get; set; }
        
    }
}