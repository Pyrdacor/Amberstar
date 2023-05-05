namespace Amberstar.Data
{
#pragma warning disable CS8981
    using word = UInt16;
#pragma warning restore CS8981

    public class Interaction
    {
        public enum TriggerType
        {
            None,
            /// <summary>
            /// Trigger key: keyword
            /// </summary>
            Keyword,
            /// <summary>
            /// Trigger key: item index
            /// </summary>
            ShowItem,
            /// <summary>
            /// Trigger key: item index
            /// </summary>
            GiveItem,
            /// <summary>
            /// Trigger key: gold amount
            /// </summary>
            GiveGold,
            /// <summary>
            /// Trigger key: food amount
            /// </summary>
            GiveFood,
            /// <summary>
            /// Trigger key is not used
            /// </summary>
            AskToJoin
        }

        public enum ReactionType
        {
            None,
            /// <summary>
            /// Displays some text.
            /// 
            /// Arg2: text index inside the characters text list
            /// </summary>
            Text,
            /// <summary>
            /// Teaches the party a new keyword.
            /// 
            /// Arg2: keyword index
            /// </summary>
            AddKeyword,
            /// <summary>
            /// Gives the party a copy of the item in the given
            /// character's item slot. Slot 0 to 8 are equipment
            /// slots and 9 and above are inventory item slots.
            /// 
            /// Arg2: character item slot index
            /// </summary>
            Item,
            /// <summary>
            /// Gives some amount of gold to the party.
            /// 
            /// Arg2: Gold amount
            /// </summary>
            Gold,
            /// <summary>
            /// Gives some amount of food to the party.
            /// 
            /// Arg2: Food amount
            /// </summary>
            Food,
            /// <summary>
            /// Sets the given quest completion flag.
            /// 
            /// Arg2: Flag index
            /// </summary>
            CompleteQuest,
            /// <summary>
            /// Changes some value of the party members' data.
            /// 
            /// Arg0: Byte offset into the party member data
            /// Arg1: Operation
            ///  - 0: Decrease
            ///  - 1: Increase
            ///  - 2: Unknown (fill?)
            ///  - 3: Unknown (remove bit?)
            ///  - 4: Set bit
            ///  - more?
            /// Arg2: Value or bit number dependent on Arg1
            /// </summary>
            ChangeStat
        }

        public class Reaction
        {
            public ReactionType Type { get; set; }
            public byte ReactionArgument0 { get; set; }
            public byte ReactionArgument1 { get; set; }
            public word ReactionArgument2 { get; set; }
        }

        public TriggerType Trigger { get; set; }
        public word TriggerKey { get; set; }
        public List<Reaction> Reactions { get; set; } = new();
    }
}
