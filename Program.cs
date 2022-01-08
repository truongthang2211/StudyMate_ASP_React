using Microsoft.AspNetCore.Server.Kestrel.Core;
using StudyMate_ASP_React.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddScoped(sp => ActivatorUtilities.CreateInstance<DBContext>(sp));

var MyAllowSpecificOrigins = "AllowSetOrigins";
builder.Services.AddControllersWithViews();
builder.Services.Configure<KestrelServerOptions>(options =>
            {
                options.AllowSynchronousIO = true;
            }); ;
builder.Services.AddCors(options =>
{
    options.AddPolicy(MyAllowSpecificOrigins,
                      builder =>
                      {
                          builder.WithOrigins("https://localhost:44481").AllowAnyMethod().AllowAnyHeader().AllowCredentials().SetIsOriginAllowedToAllowWildcardSubdomains();
                      });
});
builder.Services.AddControllers();
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
app.UseCors();
app.Run();
