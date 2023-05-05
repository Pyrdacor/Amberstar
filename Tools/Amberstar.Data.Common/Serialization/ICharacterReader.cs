using Ambermoon.Data.Serialization;

namespace Amberstar.Data.Serialization
{
    public interface ICharacterReader
    {
        void ReadCharacter(Character character, IDataReader dataReader, ITextFragmentList textFragmentList);
    }
}
