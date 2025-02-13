using HaBHAServer.Models.Client;
using HaBHAServer.Models.Dto;
using HaBHAServer.Models.Establishments;
using HaBHAServer.Models.Images;
using HaBHAServer.Models.Transactions;
using HaBHAServer.Models.User;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace HaBHAServer.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<BoardingHouse> BoardingHouses { get; set; }
        public DbSet<Amenities> Amenities { get; set; }
        public DbSet<ClientRequest> ClientRequests { get; set; }
        public DbSet<EstablishmentImageFile> ImageFiles { get; set; }
        public DbSet<BookingTransaction> BookingTransactions { get; set; }
        public DbSet<Location> Locations { get; set; }

        public DbSet<ClientRequestWithBoardinghouseDto> BoardinghouseDtos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Seed roles
            modelBuilder.Entity<IdentityRole>().HasData(
                new IdentityRole { Id = "1", Name = "SuperAdmin", NormalizedName = "SUPERADMIN" },
                new IdentityRole { Id = "2", Name = "Tenant", NormalizedName = "TENANT" },
                new IdentityRole { Id = "3", Name = "Client", NormalizedName = "CLIENT" }
            );
        }
    }
}
