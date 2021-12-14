using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Comment_Votes")]

    public class Comment_Vote
    {
        [Key]
        public int User_id { get; set; }
        public int Comment_id { get; set; }
        public bool Comment_vote_state { get; set; }
        
    }
}