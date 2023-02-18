using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Notifications")]

    public class Notification
    {
        [Key]
        public int Noti_id { get; set; }
        public int User_id { get; set; }
        public string? Content { get; set; }
        public bool? Read_state { get; set; }
        public DateTime Created_at { get; set; }
    }
}