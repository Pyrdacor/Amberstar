using Ambermoon.Data.Serialization;

namespace Amberstar.Data.Serialization
{
    public interface IItemReader
    {
        void ReadItem(Item item, IDataReader dataReader);
    }
}
