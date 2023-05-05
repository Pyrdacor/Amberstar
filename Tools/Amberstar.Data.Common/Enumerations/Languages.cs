namespace Amberstar.Data.Enumerations
{
    [Flags]
    public enum Languages : byte
    {
        None = 0,
        Human = 0x01,
        Elf = 0x02,
        Dwarf = 0x04,
        Gnome = 0x08,
        Halfling = 0x10,
        Orc = 0x20,
        Animal = 0x40
    }
}
