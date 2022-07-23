using System.Collections.Generic;

namespace CoreDockerApi
{
    public interface IDummyRepository
    {
        IList<ProductModel> GetDummyData(); 
    }
}