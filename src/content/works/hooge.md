---
date: 2019-10-30
title: HOOGE
subtitle: Hands-On Object as a Visualization for CRISPR

image: /img/works/hooge/main.jpg
headerImage: /img/works/hooge/header.jpg

links: 
  - title: dform Website
    icon: mdiOpenInNew
    url: https://www.dform.at/

categories:
  - Science Communication
  - Installation
---

## Huh?

The goal of this project was to implement a game for kids to give them a feel for how gene editing with CRISPR works.

The player should be able to remove a piece on a board and exchange it for one of the "action-pieces", if they exchanged the right pieces the game controller would play a win animation and load the next map onto a LED matrix.

Christian Manser (of d*form) was going to actually build the thing and I would write the game logic and help him hook up the LEDs and contacts for the game pieces.

::row{justify-content=center}

::video{controls class="shadow hoverable"}
:::source{src=/img/works/hooge/test.mp4}
::::
::

::

## Programming

I started programming the game controller on a cardboard test matrix. It would fit about 20 maps (15 by 15 pixels) into program memory.

A little later Christian had a (slightly more advanced) test setup of his own.

::row{justify-content=center}
![Small HOOGE](/img/works/hooge/small_hooge.jpg)
::

## Construction

The body was constructed from multiple, lasercut layers of acrylic glass – interconnected with screws. Each field on the board had 4 screws pretruding from the acrylic, which the game pieces would latch onto with magnets. The correct pieces had two long instead of four round magnets in them, with which they would close the electrical circuit between two sets of two screws thereby telling the microcontroller that an action-piece had been laid on a field. If the right action-piece was laid on one of four special fields on the board, the microcontroller would detect the piece and decide wether it was in the right spot or not.

::row{justify-content=center}
![HOOGE Backside](/img/works/hooge/hooge_backside.jpg)
::

::row{justify-content=center}
![Open Frontside](/img/works/hooge/frontside_open.jpg)
::