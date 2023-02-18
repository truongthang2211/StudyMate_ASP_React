using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Courses")]
    public class Course
    {
        [Key]
        public int Course_id { get; set; }
        public string? Course_name { get; set; }
        public long Fee { get; set; }
        public string? Course_desc { get; set; }
        public string? Img { get; set; }
        public string? Course_state { get; set; }
        public double Commission { get; set; }
        public int Course_type_id { get; set; }
        public int Author_id { get; set; }
        public DateTime? Created_at { get; set; }
        public DateTime? Updated_at { get; set; }

        public Course(int course_id, string course_name, long fee, string course_desc, string img, string course_state, double commission, int course_type_id, int author_id, DateTime created_at, DateTime updated_at)
        {
            Course_id = course_id;
            Course_name = course_name;
            Fee = fee;
            Course_desc = course_desc;
            Img = img;
            Course_state = course_state;
            Commission = commission;
            Course_type_id = course_type_id;
            Author_id = author_id;
            Created_at = created_at;
            Updated_at = updated_at;
        }

        public Course()
        {
        }
    }
}