namespace Amberstar.Data.Enumerations
{
    [Flags]
    public enum ItemFlags : byte
    {
        None = 0,
        Cursed = 0x01,
        NotImportant = 0x02,
        Stackable = 0x04,
        DestroyAfterUsage = 0x08,
        RemovableDuringFight = 0x10
    }
}
