using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Course_Subtypes")]

    public class Course_Subtype
    {
        [Key]
        public int Course_subtype_id { get; set; }
        public string? Type_name { get; set; }
        public int Parent_type_id { get; set; }
    }
}