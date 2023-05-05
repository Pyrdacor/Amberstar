using Ambermoon.Data;
using Ambermoon.Data.Serialization;
using Amberstar.Data.Enumerations;

namespace Amberstar.Data.Legacy.Serialization
{
    public class CharacterReader : Data.Serialization.ICharacterReader
    {
        public void ReadCharacter(Character character, IDataReader dataReader, ITextFragmentList textFragmentList)
        {
            character.Unk0 = dataReader.ReadByte();
            character.Unk1 = dataReader.ReadByte();
            character.Type = (Enumerations.CharacterType)dataReader.ReadByte();
            character.Gender = (Enumerations.Gender)dataReader.ReadByte();
            character.Race = (Enumerations.Race)dataReader.ReadByte();
            character.Class = (Enumerations.Class)dataReader.ReadByte();
            character.CurrentSkillAttack = dataReader.ReadByte();
            character.CurrentSkillParry = dataReader.ReadByte();
            character.CurrentSkillSwim = dataReader.ReadByte();
            character.CurrentSkillListen = dataReader.ReadByte();
            character.CurrentSkillFindTraps = dataReader.ReadByte();
            character.CurrentSkillDisarmTraps = dataReader.ReadByte();
            character.CurrentSkillLockpick = dataReader.ReadByte();
            character.CurrentSkillSearch = dataReader.ReadByte();
            character.CurrentSkillReadMagic = dataReader.ReadByte();
            character.CurrentSkillUseMagic = dataReader.ReadByte();
            character.MaxSkillAttack = dataReader.ReadByte();
            character.MaxSkillParry = dataReader.ReadByte();
            character.MaxSkillSwim = dataReader.ReadByte();
            character.MaxSkillListen = dataReader.ReadByte();
            character.MaxSkillFindTraps = dataReader.ReadByte();
            character.MaxSkillDisarmTraps = dataReader.ReadByte();
            character.MaxSkillLockpick = dataReader.ReadByte();
            character.MaxSkillSearch = dataReader.ReadByte();
            character.MaxSkillReadMagic = dataReader.ReadByte();
            character.MaxSkillUseMagic = dataReader.ReadByte();
            character.NumFreeHands = dataReader.ReadByte();
            character.NumFreeFingers = dataReader.ReadByte();
            
            for (int i = 0; i < 9; i++)
                character.EquipmentCounts[i] = dataReader.ReadByte();
            for (int i = 0; i < 12; i++)
                character.ItemCounts[i] = dataReader.ReadByte();

            character.Languages = (Languages)dataReader.ReadByte();
            character.QuestCompletionFlag = dataReader.ReadByte();
            character.CurrentAttributeStrength = dataReader.ReadWord();
            character.CurrentAttributeIntelligence = dataReader.ReadWord();
            character.CurrentAttributeDexterity = dataReader.ReadWord();
            character.CurrentAttributeSpeed = dataReader.ReadWord();
            character.CurrentAttributeStamina = dataReader.ReadWord();
            character.CurrentAttributeCharisma = dataReader.ReadWord();
            character.CurrentAttributeLuck = dataReader.ReadWord();
            character.CurrentAttributeMagicResistance = dataReader.ReadWord();
            character.CurrentAttributeAge = dataReader.ReadWord();
            character.CurrentAttributeUnused = dataReader.ReadWord();
            character.MaxAttributeStrength = dataReader.ReadWord();
            character.MaxAttributeIntelligence = dataReader.ReadWord();
            character.MaxAttributeDexterity = dataReader.ReadWord();
            character.MaxAttributeSpeed = dataReader.ReadWord();
            character.MaxAttributeStamina = dataReader.ReadWord();
            character.MaxAttributeCharisma = dataReader.ReadWord();
            character.MaxAttributeLuck = dataReader.ReadWord();
            character.MaxAttributeMagicResistance = dataReader.ReadWord();
            character.MaxAttributeAge = dataReader.ReadWord();
            character.MaxAttributeUnused = dataReader.ReadWord();
            character.CurrentHitPoints = dataReader.ReadWord();
            character.MaxHitPoints = dataReader.ReadWord();
            character.CurrentSpellPoints = dataReader.ReadWord();
            character.MaxSpellPoints = dataReader.ReadWord();
            character.Gold = dataReader.ReadWord();
            character.Food = dataReader.ReadWord();
            character.Defense = dataReader.ReadWord();
            character.Damage = dataReader.ReadWord();
            character.ExperiencePoints = dataReader.ReadWord();
            character.TotalWeight = dataReader.ReadDword();
            character.Name = dataReader.ReadString(16).TrimEnd(new char[] { '\0', ' ' });

            var itemReader = new ItemReader();
            Item ReadItem()
            {
                var item = new Item();
                itemReader.ReadItem(item, dataReader);
                return item;
            }

            for (int i = 0; i < 9; i++)
                character.Equipment[i] = ReadItem();
            for (int i = 0; i < 12; i++)
                character.Items[i] = ReadItem();

            character.Interactions = dataReader.ReadBytes(560); // TODO
            character.Portrait = GraphicReader.ReadWithHeader(dataReader);

            if (dataReader.Position < dataReader.Size)
            {
                character.Texts = new TextList(dataReader, textFragmentList).Texts;
            }
            else
            {
                character.Texts = Array.Empty<string>();
            }
        }
    }
}
