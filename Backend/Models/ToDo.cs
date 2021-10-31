using System;
using System.ComponentModel.DataAnnotations;

namespace TestAPI.Models
{
    public class ToDo
    {
        [Key]
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Status { get; set; }

    }
}

