// args[0]: Data directory (most likely called Amberfiles) containing AMBERDEV.UDO etc
// args[1]: Optional output directory (if missing, prints to console)

using Ambermoon.Data;
using Ambermoon.Data.Legacy.Serialization;
using Ambermoon.Data.Serialization;
using Amberstar.Data.Enumerations;
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

var amberdev = LoadFile("AMBERDEV.UDO");

if (amberdev == null)
    return;

var textFragments = new TextFragmentList(amberdev.Files[1], 0x21709); // this offset seems to vary between version so maybe search for it from offset 0x21000 etc

var merchantFiles = LoadFile("WARESDAT.AMB");

if (merchantFiles == null)
    return;

var chestFiles = LoadFile("CHESTDAT.AMB");

if (chestFiles == null)
    return;

var items = new List<Amberstar.Data.Item>();
var itemReader = new Amberstar.Data.Legacy.Serialization.ItemReader();

void LoadItemChunk(IDataReader dataReader)
{
    while (dataReader.Position < dataReader.Size)
    {
        var item = new Amberstar.Data.Item();
        itemReader.ReadItem(item, dataReader);

        if (item.GraphicIndex == 0)
            return;

        items.Add(item);
    }
}

foreach (var file in merchantFiles.Files)
{
    LoadItemChunk(file.Value);
}

foreach (var file in chestFiles.Files)
{
    LoadItemChunk(file.Value);
}

static string BytesToString(byte[] bytes) => string.Join(" ", bytes.Select(b => $"{b:x2}"));
static string FlagNames<TEnum>(TEnum flags, int bytes) where TEnum : Enum
{
    var names = Enum.GetNames(typeof(TEnum));
    ulong mask;
    ulong f = Convert.ToUInt64(flags);
    int bits = bytes * 8;
    string result = "";

    for (int i = 0; i < bits; ++i)
    {
        mask = 1ul << i;
        
        if ((f & mask) != 0)
        {
            if (result.Length == 0)
                result = names[i + 1];
            else
                result += " | " + names[i + 1];
        }
    }

    return result.Length == 0 ? names[0] : result;
}

if (args.Length < 2)
{
    foreach (var item in items.Where(i => i.UnknownBytes16To17.Any(b => b != 0)).Distinct(new Amberstar.Data.Item()))
    {
        Console.WriteLine();
        Console.WriteLine($"## {textFragments.Texts[item.NameID - 1]} ##");
        Console.WriteLine($"- Graphic: {item.GraphicIndex}");
        Console.WriteLine($"- Type: {item.Type}");
        Console.WriteLine($"- Used Ammo: {item.UsedAmmunitionType}");
        Console.WriteLine($"- Hands: {item.Hands}");
        Console.WriteLine($"- Fingers: {item.Fingers}");
        Console.WriteLine($"- HP: {item.HitPoints}");
        Console.WriteLine($"- SP: {item.SpellPoints}");
        Console.WriteLine($"- Attribute: {item.Attribute} {(item.Attribute == Amberstar.Data.Enumerations.Attribute.None ? "" : "+" + item.AttributeValue.ToString())}");
        if (item.SpellSchool != Amberstar.Data.Enumerations.SpellSchool.None)
            Console.WriteLine($"- Spell: {item.Attribute} {(item.Attribute == Amberstar.Data.Enumerations.Attribute.None ? "" : "+" + item.AttributeValue.ToString())}");
        Console.WriteLine($"- Defense: {item.Defense}");
        Console.WriteLine($"- Damage: {item.Damage}");
        Console.WriteLine($"- Ammo Type: {item.AmmunitionType}");
        Console.WriteLine($"- EquipmentSlot: {item.EquipmentSlot}");
        Console.WriteLine($"- M-B-W: {item.MagicWeaponLevel}");
        Console.WriteLine($"- M-B-A: {item.MagicArmorLevel}");
        if (item.Type == Amberstar.Data.Enumerations.ItemType.TextScroll)
            Console.WriteLine($"- Text: {item.SpecialIndex}.{item.SubTextIndex}");
        else if (item.Type == Amberstar.Data.Enumerations.ItemType.SpecialItem)
            Console.WriteLine($"- Special Item Type: {(SpecialItemType)item.SpecialIndex}");
        else if (item.SpecialIndex != 0)
            throw new Exception($"Unexpected special item index {item.SpecialIndex} for item type {item.Type}");
        if (item.Type != Amberstar.Data.Enumerations.ItemType.TextScroll && item.SubTextIndex != 0)
            throw new Exception($"Unexpected sub text index {item.SubTextIndex} for item type {item.Type}");
        Console.WriteLine($"- Flags: {FlagNames(item.Flags, 1)}");
        Console.WriteLine($"- UsableClasses: {item.UsableClasses:x4}");
        Console.WriteLine($"- Price: {item.Price}");
        Console.WriteLine($"- Weight: {item.Weight}");
        Console.WriteLine($"- KeyID: {item.KeyID}");
        Console.WriteLine($"- Unknown: {item.UnknownByte3:x2}");
        Console.WriteLine($"- Unknown: {BytesToString(item.UnknownBytes16To17)}");
        Console.WriteLine($"- Unknown: {BytesToString(item.UnknownBytes19To1C)}");
        Console.WriteLine();
    }
}
else
{
    /*string output = args[1];

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
    }*/
}

/*
 Rotwurz	Alterung heilen (1)
Stab des Lebens	All Heilung (6)
Gnomenpfeife	Spruchpunkte II (25)
Elfenbeinkette	Charisma 20
Silberring	S-Öffnen 15
Feuerbrand	Feuerball (20)
SANSRIS Rüstung der Ausdauer	Schutz: 18 Konstitution: 10
Ritterrüstung	LP-Max: 10 M-B-A: 2
Heiliges Schwert	MB-W: 3 Stärke: 5 Heiliges Wort (10)
Doldenkraut	Gift neutralisieren (1)
Derbelkraut	Lähmung heilen (1)
Kristallkugel	Kartenschau (100?)
Glücksbringer	Schutz: 2 Glück: 25 LP-MAX: 10
Goldring	Magische Sphäre (10)
Langbogen des SOBEK	Schaden: 20 M-B-W: 2 Attacke: 10 Wasserfall (10)
Stab des HARACHTE	Schaden: 8 M-B-W: 1 Feuersturm (6)
Rüstung des GEB	Schutz: 10 Stärke: 15
Robe der NUT	Schutz: 5 LP-MAX: 10 M-B-A: 1
Kette der BALA	Schaden: 2 Schutz: 2 Magie Abwehr: 10
Brosche der GALA	Schutz: 1 LP-MAX: 5 Wiederbelebung (5)
Füllhorn	Essen erschaffen (40)
Orb der Magie	Magische Sphäre (5)
Windstab	Windteufel (50)
Levitationspfeife	Levitation (25)
Sichel der Rückkehr	Schaden: 20
Kugel des HARACHTE	Licht 3 (100)
Brosche des SOBEK	Schwimmen: 95
Ring der Schlange	Geschick: 10
SANSRIS Halsreifen	Schutz: 5 PP-Max: 15 Charisma: 15
SANSRIS Peitsche	Schaden: 20 LP-Max: 10 M-B-W: 3
 */