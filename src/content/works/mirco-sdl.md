---
date: 2020-03-01
title: Mirco SDL
subtitle: MIdi Realtime COmputer Sequence Definition Language

image: /img/works/mirco-sdl/main.png
headerImage: /img/works/mirco-sdl/header.png

links: 
  - title: Mirco on Github
    icon: mdiGithub
    url: https://github.com/MadConductor/mirco

categories:
  - Music
---

## Huh ?

Mirco is a MIDI sequence definition language, it takes midi input and maps simple input notes to more complex patterns.
Defined sequences can be parameterised and reused, allowing the easy creation of complex, variative patterns.

A simple mirco example file:

```js
sequence seq1(A) {
    { 
    G0:2,
    _:2,
    C0:4, 
    D0:2,
    _:2} + A 
}

sequence seq3() {
    C4:50:16, /* test comment */ (C3, D#3), (C3, D#3, G3), C4|50:16
}

sequence seq4() { $trigger + {
    (C3, D#3, G3):8:2,       (C3, D#3, G3):8 + 7s, 
    (C3, D#3, G3):16,       (C3, D#3, G3)|50:16 + 7s, 
    (C3, D#3, G3):16,       (C3, D#3, G3):16 + 7s, 
    (C3, D#3, G3)|50:8:2,  (C3, D#3, G3)|50:16:2 + 7s
}}

// test comment

default: seq1($trigger)
auto: loop seq1($trigger)
C1: loop seq4()
D1: seq3()
C2: loop seq4()
C3: loop seq4()
C4: loop seq4()
```

Now hook up your MIDI equipment and run mirco in your shell!

```bash
$ ./mirco example.mirco --bpm 90 --api alsa --input 1 --output 2
```




**© Mircosoft 2020**
