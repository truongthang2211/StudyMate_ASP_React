using Microsoft.AspNetCore.Server.Kestrel.Core;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var  MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
builder.Services.AddControllersWithViews();
builder.Services.Configure<KestrelServerOptions>(options =>
            {
                options.AllowSynchronousIO = true;
            }); ;
builder.Services.AddCors(options =>
{
    options.AddPolicy( MyAllowSpecificOrigins,
                      builder =>
                      {
                          builder.WithOrigins("https://localhost:44481").AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
                      });
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();


app.MapControllerRoute(
    name: "default",
    pattern: "/{controller}/{action}");

app.MapFallbackToFile("index.html");
app.UseCors(MyAllowSpecificOrigins);
app.Run();
