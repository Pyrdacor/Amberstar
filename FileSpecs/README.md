# File specs

Here you can find all game data formats which have been decoded.

Some conventions to get you started:

I use the following data types:
- Byte (an unsigned 8-bit value)
- Word (an unsigned 16-bit value)
- Long (an unsigned 32-bit value)

If a signed type is important I will use type like:
- SByte (for signed byte)
- Short (signed word)
- Int (signed long)

I will provide tables where data structures are shown. The offsets are always given as hex values unless otherwise stated. Beside that every value starting with 0x is a hex value. For example 0x10 is the hex version of the integer 16.

**Bold** values often state unknown values, important notes and other stuff which needs some attention.