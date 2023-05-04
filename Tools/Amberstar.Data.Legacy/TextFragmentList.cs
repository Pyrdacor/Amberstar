using Ambermoon.Data.Serialization;
using Amberstar.Data.Common;

namespace Amberstar.Data.Legacy
{
    public class TextFragmentList : ITextFragmentList
    {
        private readonly List<string> texts = new();

        public TextFragmentList(IDataReader dataReader, int offset)
        {
            dataReader.Position = offset;

            while (true)
            {
                int length = dataReader.ReadByte();

                if (length == 0)
                    break;

                texts.Add(dataReader.ReadString(length - 1));
            }
        }

        public string[] Texts => texts.ToArray();
    }
}
