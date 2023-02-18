using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Users")]

    public class User
    {
        [Key]
        public int User_id { get; set; }
        public string? Fullname { get; set; }
        public DateTime? Date_of_birth { get; set; }
        public string? Email { get; set; }
        public long? Coin { get; set; }
        public string? Phone { get; set; }
        public string? School { get; set; }
        public string? Facebook { get; set; }
        public string? Linkedln { get; set; }
        public string? Avatar_img { get; set; }
        public string? Background_img { get; set; }
        public string? Bio { get; set; }
        public int? City_id { get; set; }
    }
}