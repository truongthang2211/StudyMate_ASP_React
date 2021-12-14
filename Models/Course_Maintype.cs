using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Course_Maintypes")]

    public class Course_Maintype
    {
        [Key]
        public int Course_maintype_id { get; set; }
        public string? Type_name { get; set; }
        
    }
}