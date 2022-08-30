using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore;
using EFCoreManyToMany.Data;
using EFCoreManyToMany.Models;

using (ApplicationDbContext dbContext = new ApplicationDbContext())
{
    dbContext.Database.EnsureDeleted();
    dbContext.Database.EnsureCreated();

    var drama = new Genre() { Name = "Drama" };
    var action = new Genre() { Name = "Action" };
    var animation = new Genre() { Name = "Animation" };

    var avengers = new Movie() { Title = "Avengers", Genres = new() { action } };
    var spiderman = new Movie() { Title = "Spiderman: Spiderverse", Genres = new() { action, animation } };
    var inception = new Movie() { Title = "Inception", Genres = new() { drama } };

    dbContext.AddRange(drama, action, animation, avengers, spiderman, inception);
    dbContext.SaveChanges();

    using (ApplicationDbContext context = new ApplicationDbContext())
    {
        Console.Clear();
        //var moviesWithGenres = context.movies.Include(x => x.Genres).ToList();
        //PrintMovies(moviesWithGenres);

        var actionMovies = context.movies.Include(g => g.Genres)
            .Where(movie => movie.Genres.Select(genre => genre.Name).Contains("Action"))
            .ToList();
        PrintMovies(actionMovies);
    }
}

void PrintMovies(List<Movie> moviesWithGenres)
{
    Console.ForegroundColor = ConsoleColor.Green;
    foreach (var movie in moviesWithGenres)
    {
        Console.WriteLine($"Title: {movie.Title}");
        if (movie.Genres != null)
        {
            foreach (var genre in movie.Genres)
            {
                Console.WriteLine($"  - {genre.Name}");
            }
        }
        Console.ForegroundColor = ConsoleColor.White;
    }
}