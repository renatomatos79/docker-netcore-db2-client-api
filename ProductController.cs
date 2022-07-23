using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace CoreDockerApi
{
    public class ProductController : Controller
    {
        [HttpGet("/products")]
        public async Task<IEnumerable<ProductModel>> GetProductsAsync()
        {
            // "Server=127.0.0.1:50000;Database=testdb;UID=db2inst1;PWD=myDB2@123;"
            var connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING"); 
            if (string.IsNullOrEmpty(connectionString)) {
                throw new Exception("CONNECTION_STRING variable can not be null");
            }
            byte[] data = Convert.FromBase64String(connectionString );
            string decodedString = System.Text.Encoding.UTF8.GetString(data);
            var repo = new DummyRepository(decodedString);
            return await Task.FromResult(repo.GetDummyData());
        }
    }
}
