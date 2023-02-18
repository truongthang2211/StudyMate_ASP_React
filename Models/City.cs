using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudyMate_ASP_React.Models
{
    [Table("Cities")]

    public class City
    {
        [Key]
        public int City_id { get; set; }
        public string City_name { get; set; }

        public City(int city_id, string city_name)
        {
            City_id = city_id;
            City_name = city_name;
        }
        
    }
}