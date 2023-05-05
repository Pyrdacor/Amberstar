using Ambermoon.Data.Serialization;

namespace Amberstar.Data.Legacy.Serialization
{
    public static class GraphicReader
    {
        private static readonly ushort[] Masks = new ushort[16]
        {
            0x0001, 0x0002, 0x0004, 0x0008, 0x0010, 0x0020, 0x0040, 0x0080,
            0x0100, 0x0200, 0x0400, 0x0800, 0x1000, 0x2000, 0x4000, 0x8000
        };

        public static Graphic ReadWithoutHeader(IDataReader dataReader, int width, int height, int bpp)
        {
            if (width == 0 || height == 0 || bpp == 0 || bpp == 2 || bpp > 5)
                throw new InvalidDataException($"Invalid graphic dimensions ({width}x{height}) or bpp value ({bpp}).");

            byte[] data = new byte[width * height];
            int wordsPerLine = (width + 15) / 16;

            for (int y = 0; y < height; ++y)
            {
                for (int p = 0; p < bpp; p++)
                {
                    int x = 0;
                    byte indexMask = (byte)(1 << p);

                    for (int w = 0; w < wordsPerLine; ++w)
                    {
                        var chunk = dataReader.ReadWord();

                        for (int i = 0; i < 16 && x < width; i++, x++)
                        {
                            if ((chunk & Masks[i]) != 0)
                            {
                                data[x + y * width] |= indexMask;
                            }
                        }
                    }
                }
            }

            return new Graphic(width, height, data, false);
        }

        public static Graphic ReadWithHeader(IDataReader dataReader)
        {
            int width = dataReader.ReadWord() + 1;
            int height = dataReader.ReadWord() + 1;
            int bpp = dataReader.ReadWord();

            return ReadWithoutHeader(dataReader, width, height, bpp);
        }

        public static List<Graphic> ReadList(IDataReader dataReader)
        {
            static void ThrowInvalidData() => throw new InvalidDataException("Invalid graphic list data.");

            uint totalDataSize = dataReader.ReadDword();
            int count = dataReader.ReadByte();

            if (dataReader.ReadByte() != 0)
                ThrowInvalidData();

            if (count == 0)
                return new();

            var graphics = new List<Graphic>(count);

            for (int i = 0; i < count; ++i)
            {
                uint size = dataReader.ReadDword();

                if (size > totalDataSize)
                    ThrowInvalidData();

                int position = dataReader.Position;
                graphics.Add(ReadWithHeader(dataReader));

                if (position + size != dataReader.Position)
                    ThrowInvalidData();

                totalDataSize -= size;
            }

            if (totalDataSize != 0)
                ThrowInvalidData();

            return graphics;
        }
    }
}
