// args[0]: Data directory (most likely called Amberfiles) containing AMBERDEV.UDO etc
// args[1]: Optional output directory (if missing, prints to console)

using Ambermoon.Data;
using Ambermoon.Data.Legacy;
using Ambermoon.Data.Legacy.Serialization;
using Amberstar.Data.Legacy;

var reader = new FileReader();

IFileContainer? LoadFile(string name)
{
    string path = Path.Combine(args[0], name);

    if (!File.Exists(path))
    {
        Console.WriteLine("Could not find file: " + path);
        return null;
    }
    
    return reader.ReadFile(name, new DataReader(File.ReadAllBytes(path)));
}

var amberdev = LoadFile(AmberstarFiles.Entries[0]); // TODO

if (amberdev == null)
    return;

var textFragments = new TextFragmentList(amberdev.Files[1], 0x21709); // this offset seems to vary between version so maybe search for it from offset 0x21000 etc
var dict = new Dictionary<string, Dictionary<uint, TextList>>();

foreach (var textFile in AmberstarFiles.TextFileEntries)
{
    var container = LoadFile(textFile);

    if (container == null)
        continue;


    dict.Add(textFile, new Dictionary<uint, TextList>());

    foreach (var subFile in container.Files)
    {
        var textList = new TextList(subFile.Value, textFragments);
        dict[textFile].Add((uint)subFile.Key, textList);
    }
}

if (args.Length < 2)
{
    foreach (var entry in dict)
    {
        Console.WriteLine();
        Console.WriteLine($"## {entry.Key} ##");
        Console.WriteLine();

        foreach (var list in entry.Value)
        {
            Console.WriteLine($"-- {list.Key} --");

            foreach (var text in list.Value.Texts)
                Console.WriteLine(text);
        }

        Console.WriteLine();
    }
}
else
{
    string output = args[1];

    foreach (var entry in dict)
    {
        string dir = Path.Combine(output, entry.Key);
        Directory.CreateDirectory(dir);

        foreach (var list in entry.Value)
        {
            string subdir = Path.Combine(dir, list.Key.ToString("000"));
            Directory.CreateDirectory(subdir);

            int index = 0;

            foreach (var text in list.Value.Texts)
            {
                File.WriteAllText(Path.Combine(subdir, $"{index++:000}.txt"), text);
            }
        }
    }
}
