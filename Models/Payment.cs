using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Payments")]

    public class Payment
    {
        [Key]
        public int Payment_id { get; set; }
        public int User_id { get; set; }
        public int Receiver_id { get; set; }
        public long Amount { get; set; }
        public int Enrollment_id { get; set; }
    }
}