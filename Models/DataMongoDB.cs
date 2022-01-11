using MongoDB.Driver;

namespace StudyMate_ASP_React.Models
{
    public class DataMongoDB
    {
        public DataMongoDB()
        {
            Client = new MongoClient("mongodb+srv://sanke2211:FvgMPpstfXJaJO7i@cluster0.nlul1.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
            DB = Client.GetDatabase("StudyMate");
        }
        private MongoClient Client { get; set; }
        public IMongoDatabase DB { get; set; }
    }
}