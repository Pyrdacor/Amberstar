using Ambermoon.Data.Serialization;

namespace Amberstar.Data.Legacy
{
    public class TextList : ITextList
    {
        public TextList(IDataReader textInfoReader, ITextFragmentList textFragmentList)
        {
            int count = textInfoReader.ReadByte();
            ++textInfoReader.Position;

            if (count == 0)
            {
                Texts = Array.Empty<string>();
                return;
            }

            int[] lengths = new int[count];
            int start = textInfoReader.ReadWord();

            for (int i = 0; i < count; i++)
            {
                int next = textInfoReader.ReadWord();
                lengths[i] = next - start;
                start = next;
            }

            Texts = new string[count];

            for (int i = 0; i < count; i++)
            {
                string text = "";
                bool lastWasNewline = true;

                for (int n = 0; n < lengths[i]; n++)
                {
                    int x = textInfoReader.ReadWord() - 1;
                    string textFragment = textFragmentList.Texts[x].Replace('#', '\n');

                    if (textFragment.Length != 0)
                    {
                        if (!lastWasNewline && (char.IsLetter(textFragment[0]) || char.IsNumber(textFragment[0]) || textFragment[0] == '-' || textFragment[0] == '~') &&
                            !text.EndsWith("\n\"") && !text.EndsWith(" \""))
                            text += " ";
                        text += textFragment;
                        lastWasNewline = textFragment.EndsWith('\n');
                    }
                }

                Texts[i] = text;
            }
        }

        public string[] Texts { get; }
    }
}
