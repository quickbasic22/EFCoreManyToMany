using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EFCoreManyToMany.Models
{
    public class Genre
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [StringLength(30)]
        public string Name { get; set; }
        public List<Movie> Movies { get; set; }
    }

}