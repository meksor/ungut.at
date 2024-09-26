---
date: 2018-07-04
title: Annoying Assholes
subtitle: Weapon of Mass Annoyance

image: /img/works/annoying-assholes/main.jpg
headerImage: /img/works/annoying-assholes/header.jpg

links: 
  - title: PCB and Code on Github
    icon: mdiGithub
    url: https://github.com/meksor/onehundredannoyingassholes

categories:
  - Electronics
---

## The Idea

I actually didn't know something like this existed already until I looked it up. Although I could have expected it to, in light of human mischief. I still didn't find a version I liked.

[This one](http://www.instructables.com/id/Buzzer-Throwie/) for example, is just a battery taped to a piezo speaker, which means it's active all the time and will be easily found. A friend of mine apperently also built [something similar](https://chaosfield.at/projects/annoyotron.html), although it is not designed for "mass"-production. He even used an Attiny13 and wrote all the code directly in C, instead of using something like the Arduino IDE. The [Annoy-O-Bug](https://www.hackster.io/AlexWulff/the-annoy-o-bug-a-chirping-light-up-throwie-37e58a) is a little different, it has a small mircocontroller and an LED. It uses the Attiny85. The undesired side-effect: One of theses costs almost 5 Euros.

I knew I had to make it more affordable, so I consulted with a few of my electronics-affine friends. Our first instinct was to use two timers, one for the long intervals between beeps and one for the PWM for the piezo speaker. Upon looking it up, we found that an Attiny25 was actually cheaper, so we went for that.

## The Prototype

[Overflo](https://github.com/overflo23), who owns [hackerspaceshop.com](https://hackerspaceshop.com/) sent me a bunch of components to build a prototype. What an incredibly nice man!

It was like Christmas!

::row{justify-content=center}
![Goodies](/img/works/annoying-assholes/goodies.jpg){width=750px}
::

The first PCB was designed by [Amir](https://github.com/kallaballa) in a CAD program and home-made at our local hackerspace [Metalab](http://metalab.at/).

We used spraypaint for the mask, which we removed with a LASER-Cutter where we wanted the copper to dissolve.

::row{justify-content=center}
![LAZZZORED](/img/works/annoying-assholes/etching_lazzzored.jpg)
::

Metalab's heater for the acid bath was pretty broken, so we tried to build a new one:

::row{justify-content=center}
![Failed Heater](/img/works/annoying-assholes/etching_new_heater.jpg)
::

But that didn't work either so I just sat there with a hot-air-gun to keep it from getting too chilly.

Needless to say, we noticed a mistake in the design right after it was done etching. Thankfully this was easily fixable:

::row{justify-content=center}
![Failed Heater](/img/works/annoying-assholes/etching_fixed_prototype.jpg)
::

We still wanted a proper PCB so we did it all again with a fixed design.

This was the finished prototype:

::row{justify-content=center}
::youtube-video{video-id="84bH-g-eUzU"}
::
::

## Final Version

[Vic](https://metalab.at/wiki/Benutzer:Vic) showed us around KiCAD and designed the final PCB for us!

For the next step we had those made and bought all the other parts. Being multiple people, we were able to parallelize the work. Splitting it into: Flashing the Chips using a POMONA-Clip, applying the solder paste, baking the PCBs and hand soldering the components. Thanks for your help, [Mumpitz](http://mumpitz.at/) (:

The final version was programmed to go into deep-sleep for 15-30 minutes, wake back up, beep randomly and go back to sleep.

::row{justify-content=center}
![Done!](/img/works/annoying-assholes/done.jpg)
::


Done! We ordered about a hundred of these and I stored a few to give to the people that helped along the way.

A little later a few former school collegues and me distributed the rest at our ex-school to wreak destruction, annoyance and havoc there! We even hot-glued magnets on some of the throwies to hide them in particularly evil places :D

Amir and me tested how long these things would survive, but they drove us both insane after a couple of months so we killed them by force before we could observe one running out of battery.

They say on quiet evenings one can still hear one hundred annoying assholes chirping away in the dark and grim hallways of the "Die Graphische" school building.
