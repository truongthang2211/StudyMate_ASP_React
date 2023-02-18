using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Enrollments")]

    public class Enrollment
    {
        [Key]
        public int Enrollment_id { get; set; }
        public int User_id { get; set; }
        public int Course_id { get; set; }
        public DateTime? Enroll_time { get; set; }
    }
}