namespace Amberstar.Data
{
    using Amberstar.Data.Enumerations;
#pragma warning disable CS8981
    using word = UInt16;
    using dword = UInt32;
#pragma warning restore CS8981

    public class Character
    {
        public byte Unk0 { get; set; }
        public byte Unk1 { get; set; }
        public CharacterType Type { get; set; }
        public Gender Gender { get; set; }
        public Race Race { get; set; }
        public Class Class { get; set; }
        public byte CurrentSkillAttack { get; set; }
        public byte CurrentSkillParry { get; set; }
        public byte CurrentSkillSwim { get; set; }
        public byte CurrentSkillListen { get; set; }
        public byte CurrentSkillFindTraps { get; set; }
        public byte CurrentSkillDisarmTraps { get; set; }
        public byte CurrentSkillLockpick { get; set; }
        public byte CurrentSkillSearch { get; set; }
        public byte CurrentSkillReadMagic { get; set; }
        public byte CurrentSkillUseMagic { get; set; }
        public byte MaxSkillAttack { get; set; }
        public byte MaxSkillParry { get; set; }
        public byte MaxSkillSwim { get; set; }
        public byte MaxSkillListen { get; set; }
        public byte MaxSkillFindTraps { get; set; }
        public byte MaxSkillDisarmTraps { get; set; }
        public byte MaxSkillLockpick { get; set; }
        public byte MaxSkillSearch { get; set; }
        public byte MaxSkillReadMagic { get; set; }
        public byte MaxSkillUseMagic { get; set; }
        public byte NumFreeHands { get; set; } // TODO: or used hands?
        public byte NumFreeFingers { get; set; } // TODO: or used fingers?
        /// <summary>
        /// 9 slots
        /// </summary>
        public byte[] EquipmentCounts { get; } = new byte[9];
        /// <summary>
        /// Inventory
        /// 12 slots
        /// </summary>
        public byte[] ItemCounts { get; } = new byte[12];
        public Languages Languages { get; set; }
        /// <summary>
        /// Specifies an ID of a flag which controls which of
        /// the two conversation reactions are used.
        /// </summary>
        public byte QuestCompletionFlag { get; set; }
        public word CurrentAttributeStrength { get; set; }
        public word CurrentAttributeIntelligence { get; set; }
        public word CurrentAttributeDexterity { get; set; }
        public word CurrentAttributeSpeed { get; set; }
        public word CurrentAttributeStamina { get; set; }
        public word CurrentAttributeCharisma { get; set; }
        public word CurrentAttributeLuck { get; set; }
        public word CurrentAttributeMagicResistance { get; set; }
        public word CurrentAttributeAge { get; set; }
        public word CurrentAttributeUnused { get; set; }
        public word MaxAttributeStrength { get; set; }
        public word MaxAttributeIntelligence { get; set; }
        public word MaxAttributeDexterity { get; set; }
        public word MaxAttributeSpeed { get; set; }
        public word MaxAttributeStamina { get; set; }
        public word MaxAttributeCharisma { get; set; }
        public word MaxAttributeLuck { get; set; }
        public word MaxAttributeMagicResistance { get; set; }
        public word MaxAttributeAge { get; set; }
        public word MaxAttributeUnused { get; set; }
        public word CurrentHitPoints { get; set; }
        public word MaxHitPoints { get; set; }
        public word CurrentSpellPoints { get; set; }
        public word MaxSpellPoints { get; set; }
        public word Gold { get; set; }
        public word Food { get; set; }
        public word Defense { get; set; }
        public word Damage { get; set; }
        public word ExperiencePoints { get; set; }
        public dword TotalWeight { get; set; }
        public string Name { get; set; }
        /// <summary>
        /// 9 slots
        /// </summary>
        public Item[] Equipment { get; set; } = new Item[9];
        /// <summary>
        /// Inventory
        /// 12 slots
        /// </summary>
        public Item[] Items { get; set; } = new Item[12];
        public byte[]? Interactions { get; set; } // TODO, 560 bytes
        public Graphic? Portrait { get; set; }
        public string[]? Texts { get; set; }
    }
}
