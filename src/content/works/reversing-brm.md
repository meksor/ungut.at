---
date: 2022-06-10
title: REZAL 
subtitle: Reverse Engineering a BRM 90130 Lasercutter

image: /img/works/reversing-brm/main.png
headerImage: /img/works/reversing-brm/header.png

links: 
  - title: Metalab Wiki
    icon: mdiWorld
    url: https://metalab.at/wiki/Laser/Hacking
  - title: Ctrl+Cut Branch on Github
    icon: mdiGithub
    url: https://github.com/kallaballa/ctrl-cut/tree/brm
  - title: Stefan Schuermans
    icon: mdiWorld
    url: https://stefan.schuermans.info/rdcam/scrambling.html

categories:
  - Software
---

## Why would you try to reverse engineer a lasercutter?

Once upon a time, when metalab got its first lasercutter, a small group of hackers decided to 
invest some time in writing their own driver, feature-complete, with its own GUI.
They did this because the available accompanying driver software sucked and did not allow easy imports of
certain file types. I actually dont know that for sure, I am just retelling this story and filling in the blanks.

Towards the end of my short but sweet hackerspace career, metalab invested in a new lasercutter to replace the old one.

Chinese lasercutter driver technology had evolved and the supplied driver was unintuitive and hard to use
but quite extensive and already had support for the vendor specific hardware that came with the thing 
(like a rotary engraving mount).

Don't fret, chinese lasercutter driver technology cannot defeat whimsical hacker enthusiasm: 
[Amir](https://github.com/kallaballa) and me decided to try to reverse engineer the new protocol and add support
to his open-source driver.


## Where do you even start?

That's a good question. I am not an experienced "reverse-engineer" (do those exist?), but when trying to decode some file or replicate some legacy-api's behaviour, I always try to the things I already have available to me somehow. In this case we were lucky, the shipped driver included features to both save a job to a file and send it directly via USB or network.

Amir tried to debug the network feature before I joined him according to his [mastodon posts](https://chaos.social/@lazzzzzor), but let's be honest: its unlikely that someone put in the unnecessary effort of making the different ways of sending a job differ in the actual protocol. So we switched approaches: dumping the exported files as binary and looking at them in a hex-editor.

What we found did not make much sense, moving a single point in the driver did not result in certain values being higher or lower. 
The data seemed scrambled, there was not a single `0x00` byte in the entire job. The most common byte was `0x34`, which later turned out to actually be `0x00`

Puzzelled we looked at this giant machine for anwers, but found a hilarious misspelling of "Internet" instead:

![Intenet](/img/works/reversing-brm/Intenet.png)


## Enter the "Intenet"

Thankfully, we were not alone and also not the first ones to try to reverse-engineer a lasercutter with this particular type of board.
Apparently [this guy did it](https://stefan.schuermans.info/rdcam/scrambling.html) as well and it turns out that he did most of the work for us.
The entire file is scrambled, byte by byte:

```c
uint8_t scramble(uint8_t p) {
    uint8_t a = p & 0x7E | p >> 7 & 0x01 | p << 7 & 0x80;
    uint8_t b = a ^ MAGIC;
    uint8_t s = (b + 1) & 0xFF;
    return s; 
}

uint8_t descramble(uint8_t s) {
 uint8_t a = (s + 0xFF) & 0xFF;
 uint8_t b = a ^ MAGIC;
 uint8_t p = b & 0x7E | b >> 7 & 0x01 | b << 7 & 0x80;
 return p;
}
```

Luckily, with only 255 combinations for the possible magic number, I could brute-force it pretty quickly.

Let it be known, for the BRM 90130 Lasercutter:

```c
#define MAGIC 0x33
```

## "Now for the tricky part"

While Amir wrote a pretty cool [emulator for the laser](https://github.com/kallaballa/rdint), I started 
working on generating the data for a job from the ctrl+cut internal represenation. 

[This is how far we got](https://github.com/kallaballa/ctrl-cut/blob/brm/src/ctrl-cut/cutters/encoder/RdEncoder.cpp) 
before we got distracted. It worked! (I know this picture is very smokey, sorry :()

![Test Cut](/img/works/reversing-brm/test_cut.png)


## Btw, we engraved an egg in the very beginning: 

![egg](/img/works/reversing-brm/egg.png)