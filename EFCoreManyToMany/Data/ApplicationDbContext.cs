using EFCoreManyToMany.Models;
using Microsoft.EntityFrameworkCore;

namespace EFCoreManyToMany.Data
{
    public class ApplicationDbContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Data Source=Movies.db").LogTo(Console.WriteLine, Microsoft.Extensions.Logging.LogLevel.Information);

        }

        public DbSet<Genre> Genres { get; set; }
        public DbSet<Movie> movies { get; set; }
    }
}

