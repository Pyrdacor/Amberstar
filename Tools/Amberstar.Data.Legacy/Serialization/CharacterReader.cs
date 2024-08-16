using Amberstar.Data.Serialization;
using Amberstar.Data.Enumerations;

namespace Amberstar.Data.Legacy.Serialization
{
#pragma warning disable CS8981
    using word = UInt16;
#pragma warning restore CS8981

    public class CharacterReader : ICharacterReader
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
            character.Unk1A = dataReader.ReadByte();
            character.Unk1B = dataReader.ReadByte();
            character.NumUsedHands = dataReader.ReadByte();
            character.NumUsedFingers = dataReader.ReadByte();
            character.Unk1E = dataReader.ReadByte();
            character.Unk1F = dataReader.ReadByte();
            character.Unk20 = dataReader.ReadByte();
            character.Unk21 = dataReader.ReadByte();

            for (int i = 0; i < 9; i++)
                character.EquipmentCounts[i] = dataReader.ReadByte();
            for (int i = 0; i < 12; i++)
                character.ItemCounts[i] = dataReader.ReadByte();

            character.Languages = (Languages)dataReader.ReadByte();
            character.Unk38 = dataReader.ReadByte();
            character.Unk39 = dataReader.ReadByte();
            character.Unk3A = dataReader.ReadByte();
            character.Unk3B = dataReader.ReadByte();
            character.Unk3C = dataReader.ReadByte();
            character.QuestCompletionFlag = dataReader.ReadByte();
            character.Unk3ETo47 = dataReader.ReadBytes(10);
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
            character.Unk70To85 = dataReader.ReadBytes(22);
            character.CurrentHitPoints = dataReader.ReadWord();
            character.MaxHitPoints = dataReader.ReadWord();
            character.CurrentSpellPoints = dataReader.ReadWord();
            character.MaxSpellPoints = dataReader.ReadWord();
            character.Unk8E = dataReader.ReadByte();
            character.Unk8F = dataReader.ReadByte();
            character.Gold = dataReader.ReadWord();
            character.Food = dataReader.ReadWord();
            character.Defense = dataReader.ReadWord();
            character.Damage = dataReader.ReadWord();
            character.Unk98ToCD = dataReader.ReadBytes(54);
            character.ExperiencePoints = dataReader.ReadWord();
            character.UnkD0ToEB = dataReader.ReadBytes(28);
            character.TotalWeight = dataReader.ReadDword();
            character.Name = dataReader.ReadString(16).TrimEnd(new char[] { '\0', ' ' });
            character.Unk100To131 = dataReader.ReadBytes(50);

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

            ReadInteractions(character, dataReader);

            if (dataReader.Position < dataReader.Size)
            {
                if (dataReader.PeekWord() != 0)
                    character.Portrait = GraphicReader.ReadWithHeader(dataReader);
                else
                {
                    character.Texts = Array.Empty<string>();
                    return;
                }
            }

            if (dataReader.Position < dataReader.Size)
            {
                character.Texts = new TextList(dataReader, textFragmentList).Texts;
            }
            else
            {
                character.Texts = Array.Empty<string>();
            }
        }

        private static void ReadInteractions(Character character, IDataReader dataReader)
        {
            character.Interactions.Clear();
            int position = dataReader.Position;

            var triggerTypes = dataReader.ReadBytes(20);

            for (int i = 0; i < 20; i++)
            {
                if (triggerTypes[i] != 0)
                {
                    dataReader.Position = position + 20 + i * 2;
                    var interaction = new Interaction()
                    {
                        Trigger = (Interaction.TriggerType)triggerTypes[i],
                        TriggerKey = dataReader.ReadWord()
                    };
                    dataReader.Position = position + 60 + i * 5;
                    var reactionTypes = dataReader.ReadBytes(5);

                    for (int r = 0; r < 5; r++)
                    {
                        if (reactionTypes[r] != 0)
                        {
                            dataReader.Position = position + 160 + i * 5 + r;
                            var arg0 = dataReader.ReadByte();
                            dataReader.Position = position + 260 + i * 5 + r;
                            var arg1 = dataReader.ReadByte();
                            dataReader.Position = position + 360 + i * 10 + r;
                            var arg2 = dataReader.ReadWord();

                            interaction.Reactions.Add(new Interaction.Reaction()
                            {
                                Type = (Interaction.ReactionType)reactionTypes[r],
                                ReactionArgument0 = arg0,
                                ReactionArgument1 = arg1,
                                ReactionArgument2 = arg2
                            });
                        }
                    }

                    character.Interactions.Add(interaction);
                }
            }

            dataReader.Position = position + 560;
        }
    }
}
