using Ambermoon.Data.Serialization;
using Amberstar.Data.Enumerations;

namespace Amberstar.Data.Legacy.Serialization
{
    public class ItemReader : Data.Serialization.IItemReader
    {
        public void ReadItem(Item item, IDataReader dataReader)
        {
            item.GraphicIndex = dataReader.ReadByte();
            item.Type = (ItemType)dataReader.ReadByte();
            item.UsedAmmunitionType = (AmmunitionType)dataReader.ReadByte();
            item.UnknownByte3 = dataReader.ReadByte();
            item.Hands = dataReader.ReadByte();
            item.Fingers = dataReader.ReadByte();
            item.HitPoints = dataReader.ReadByte();
            item.SpellPoints = dataReader.ReadByte();
            item.Attribute = (Enumerations.Attribute)dataReader.ReadByte();
            item.AttributeValue = dataReader.ReadByte();
            item.Skill = (Skill)dataReader.ReadByte();
            item.SkillValue = dataReader.ReadByte();
            item.SpellSchool = (SpellSchool)dataReader.ReadByte();
            item.SpellIndex = dataReader.ReadByte();
            item.SpellCharges = dataReader.ReadByte();
            item.AmmunitionType = (AmmunitionType)dataReader.ReadByte();
            item.Defense = dataReader.ReadByte();
            item.Damage = dataReader.ReadByte();
            item.EquipmentSlot = (EquipmentSlot)dataReader.ReadByte();
            item.MagicWeaponLevel = dataReader.ReadByte();
            item.MagicArmorLevel = dataReader.ReadByte();
            item.SpecialIndex = dataReader.ReadByte();
            item.UnknownBytes16To17 = dataReader.ReadBytes(2);
            item.Flags = (ItemFlags)dataReader.ReadByte();
            item.UnknownBytes19To1C = dataReader.ReadBytes(4);
            item.SubTextIndex = dataReader.ReadByte();
            item.UsableClasses = dataReader.ReadWord();
            item.Price = dataReader.ReadWord();
            item.Weight = dataReader.ReadWord();
            item.KeyID = dataReader.ReadWord();
            item.NameID = dataReader.ReadWord();
        }
    }
}
