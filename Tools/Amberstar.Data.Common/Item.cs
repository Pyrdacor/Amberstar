using System.Diagnostics.CodeAnalysis;
using Amberstar.Data.Enumerations;

namespace Amberstar.Data
{
    public class Item : IEqualityComparer<Item>
    {
        public byte GraphicIndex { get; set; }
        public ItemType Type { get; set; }
        public AmmunitionType UsedAmmunitionType { get; set; }
        public byte UnknownByte3 { get; set; }
        public byte Hands { get; set; }
        public byte Fingers { get; set; }
        public byte HitPoints { get; set; }
        public byte SpellPoints { get; set; }
        public Enumerations.Attribute Attribute { get; set; }
        public byte AttributeValue { get; set; }
        public Skill Skill { get; set; }
        public byte SkillValue { get; set; }
        public SpellSchool SpellSchool { get; set; }
        public byte SpellIndex { get; set; } // 0 means none
        public byte SpellCharges { get; set; }
        public AmmunitionType AmmunitionType { get; set; }
        public byte Defense { get; set; }
        public byte Damage { get; set; }
        public EquipmentSlot EquipmentSlot { get; set; }
        public byte MagicWeaponLevel { get; set; }
        public byte MagicArmorLevel { get; set; }
        public byte SpecialIndex { get; set; } // special item type or code text container index
        public byte[] UnknownBytes16To17 { get; set; }
        public ItemFlags Flags { get; set; }
        public byte[] UnknownBytes19To1C { get; set; }
        public byte SubTextIndex { get; set; }
        public ushort UsableClasses { get; set; } // TODO: use flag enum later
        public ushort Price { get; set; }
        public ushort Weight { get; set; } // in grams
        public ushort KeyID { get; set; } // quest marker
        public ushort NameID { get; set; } // id into the text fragment table

        public bool Equals(Item? x, Item? y)
        {
            if (x == null)
                return y == null;
            else if (y == null)
                return false;

            return x.GraphicIndex == y.GraphicIndex && x.NameID == y.NameID && x.KeyID == y.KeyID;
        }

        public int GetHashCode([DisallowNull] Item obj)
        {
            return HashCode.Combine(NameID, KeyID, GraphicIndex);
        }
    }
}
