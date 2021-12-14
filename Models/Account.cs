using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Accounts")]

    public class Account
    {
        [Key]
        public int Account_id { get; set; }
        public int User_id { get; set; }
        public string? Username { get; set; }
        public string? Pwd { get; set; }
        public string? Account_role { get; set; }
        public DateTime? Created_at { get; set; }

        public Account(int account_id, int user_id, string username, string pwd, string account_role, DateTime created_at)
        {
            Account_id = account_id;
            User_id = user_id;
            Username = username;
            Pwd = pwd;
            Account_role = account_role;
            Created_at = created_at;
        }

        public Account()
        {
        }
    }
}