---
date: 2023-07-01
title: mechanizm
subtitle: Rythm based Video Editing

image: /img/works/mechanizm/main.png
headerImage: /img/works/mechanizm/header.png

links: 
  - title: mechanizm on Github
    icon: mdiGithub
    url: https://github.com/meksor/mechanizm

categories:
  - Software
  - Music
---

## Huh?

The next piece of software on my quest for the perfect music video. This program allows me to map video keyframes to midi files. Boring, slow, unrythmic videos can be re-mapped to simple rythms, perfect for found-footage video generation. 

::row{justify-content=center}
::youtube-video{video-id="F2QVizDAV24"}
::
::

### MIDI Generation
Depending on if the music was home-made, the vicinity to the producer or the production workflow itself one might have a hard time getting usable midi data.
In this case, the spurious process of reverse-engineering music begins:

First the track needs to be split up into individual instruments.
[Open source projects](https://github.com/deezer/spleeter) accomplishing this exist.
Not wanting to set this up I used this [ridiculously undersold conversion tool](https://www.conversion-tool.com/voiceseparator/).

Afterwards the split tracks can be converted to midi by filtering for relevant frequencies and setting thresholds to trigger midi notes.
[Reaper](https://www.reaper.fm/) offers a wide range of control for doing this. Other digital audio workstations are available.

::row{justify-content=center}
![Reaper MIDI Trigger](/img/works/mechanizm/reaper_midi_trigger.png)
::

### Mechanizm

Next the source videos are imported into mechanizm and rythmic points can be defined.

::row{justify-content=center}
![Mechanizm Clips Window](/img/works/mechanizm/clips.png)
::

These "clips" can then be mapped to the MIDI files from above. Here I mapped the kick to increase the position to the next key frame and the snare to do the opposite: 

::row{justify-content=center}
::youtube-video{video-id="90dgnRil07I"}
::
::

### Composition & Post-Processing

After the mapped clips are exported from mechanizm, they can be composited and assembled in a video editor (or Reaper, for that matter). Since editing and compositing videos and audio is an "ESP" (*Extremely Solved Problem*) I won't go into detail here.

Then we can do whatever else we want. The first video is additionally [colorized with a neural network](https://github.com/jantic/DeOldify).
