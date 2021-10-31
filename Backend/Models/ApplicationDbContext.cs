using System;
using Microsoft.EntityFrameworkCore;

namespace TestAPI.Models
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
        public DbSet<ToDo> ToDos { get; set; }


    }
}

