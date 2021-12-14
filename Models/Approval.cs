using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Approvals")]

    public class Approval
    {
        [Key]
        public int Approval_id { get; set; }
        public int Course_id { get; set; }
        public DateTime? Approve_time { get; set; }
        public bool Accept { get; set; }
        public string? Reason { get; set; }

        public Approval(int approval_id, int course_id, DateTime approve_time, bool accept, string reason)
        {
            Approval_id = approval_id;
            Course_id = course_id;
            Approve_time = approve_time;
            Accept = accept;
            Reason = reason;
        }

        public Approval()
        {
        }
    }
}