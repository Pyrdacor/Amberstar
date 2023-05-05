namespace Amberstar.Data
{
    public class Graphic
    {
        public Graphic(int width, int height, byte paletteIndex)
        {
            Width = width;
            Height = height;
            Data = new byte[width * height];

            if (paletteIndex != 0)
                Array.Fill(Data, paletteIndex);
        }

        public Graphic(int width, int height, byte[] data, bool createCopy = true)
        {
            if (data.Length != width * height)
                throw new ArgumentException("Given graphic data size must match width times height.");

            Width = width;
            Height = height;

            if (createCopy)
            {
                Data = new byte[data.Length];
                Buffer.BlockCopy(data, 0, Data, 0, data.Length);
            }
            else
            {
                Data = data;
            }
        }

        public int Width { get; }
        public int Height { get; }
        /// <summary>
        /// For now the data always contains one palette index per byte
        /// so the size of Data is Width * Height.
        /// </summary>
        public byte[] Data { get; }
    }
}
