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

 0. **MIDI Generation**:
    - Source audio is split using a track-seperation model
    - MIDI tracks are generated from split audio with thresholding and filtering
 0. **Mechanizm**:
    - Keyframes in the source video are defined
    - MIDI tracks are mapped to keyframe mutation logic, for example
        - kick = one frame forwards
        - snare = one frame backwards

 0. **Composition**:
    - the video is rendered, composited and cut
    - the result is colorized using a colorization model


::row{justify-content=center}
::youtube-video{video-id="90dgnRil07I"}
::
::

intermediate video, cool!
