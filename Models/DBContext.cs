using Microsoft.EntityFrameworkCore;

namespace StudyMate_ASP_React.Models
{
    public class DBContext : DbContext
    {
        // Chuỗi kết nối tới CSDL (MS SQL Server)
        private const string connectionString = @"
                 server=localhost;port=3306;database=studymate;user=root;password=";

        // Phương thức OnConfiguring gọi mỗi khi một đối tượng DbContext được tạo
        // Nạp chồng nó để thiết lập các cấu hình, như thiết lập chuỗi kết nối
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseMySql(connectionString, new MySqlServerVersion(new Version(8, 0, 27)));
        }
        public DbSet<Account>? accounts { set; get; }
        public DbSet<Approval>? approvals { set; get; }
        public DbSet<City>? cities { set; get; }
        public DbSet<Comment_Vote>? comment_votes { set; get; }
        public DbSet<Comment>? comment { set; get; }
        public DbSet<Course_Chapter>? course_chapters { set; get; }
        public DbSet<Course_Gain>? course_gains { set; get; }
        public DbSet<Course_Maintype>? course_maintypes { set; get; }
        public DbSet<Course_Require>? course_requires { set; get; }
        public DbSet<Course_Review>? course_reviews { set; get; }
        public DbSet<Course_Subtype>? course_subtypes { set; get; }
        public DbSet<Course>? courses { set; get; }
        public DbSet<Enrollment>? enrollments { set; get; }
        public DbSet<Learning>? learnings { set; get; }
        public DbSet<Lesson>? lessons { set; get; }
        public DbSet<Notification>? notifications { set; get; }
        public DbSet<Payment>? payments { set; get; }
        public DbSet<User>? users { set; get; }
        public T? ConvertFromDBVal<T>(object obj)
        {
            if (obj == null || obj == DBNull.Value)
            {
                return default(T); // returns the default value for the type
            }
            else
            {
                return (T)obj;
            }
        }
    }
}