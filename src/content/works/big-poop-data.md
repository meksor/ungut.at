---
date: 2017-11-07
title: Big Poop Data (.com)
subtitle: Shitty Datascience

image: /img/works/bpd/main.png
headerImage: /img/works/bpd/header.png

links: 
  - title: BPD on Github
    icon: mdiGithub
    url: https://github.com/BigPoopData
  - title: Ars Electronica Blog
    icon: mdiOpenInNew
    url: https://ars.electronica.art/aeblog/en/2017/06/02/bigpoopdata/
  - title: Open Minds
    icon: mdiOpenInNew
    url: https://futurezone.at/digital-life/open-minds-awards-an-zehn-it-projekte-verliehen/288.897.289

categories:
  - Website
  - Art
---

## Laziness is the mother of invention. 

It all started with a long evening in the metalab lounge: My friend Nico had gone to the toilet only to return in defeat, having been unable to accomplish his goal. "Someone's on there again" he said, returning to his particular dent in the couch which had formed over the hours of him sitting there.

A couple of minutes later he tried again but alas, for the third time, another person had beat him to the shitter.

> "This is unacceptable"

Nico exclaimed angrily. 

So he did what any sane hacker would do: He installed a button in the toilet door. It's purpose: to be hooked up to a small computer to enable remote monitoring of the toilet door state.

::row{justify-content=center}
![Button](/img/works/bpd/button.jpg)
::

But of course that was the premature end of the project as it sank to the bottom of the (very familiar) ocean of procrastination.

## Until...

...we had to come up with a project to participate at the Ars Electronica Festival. My project partners (Robert Miller and Daniel Wetzelhütter) and I looked at our teacher in distress.
Was he serious?

Not an ounce of mercy was to be found in his cold dead eyes, staring back at us as if to say: "Get to work".

So relucantly we started brainstorming and came up with the idea to build monitoring software with a corporate style analytics frontend for the button on the metalab toilet.

Not unlike in the classic story about the inception of the name of the iconic computer manufacturer "Apple", none of us managed to find a better project name than "BigPoopData" like i had originally suggested and so the name and idea stuck.

## Development

Shortly after we contacted Nico if he wanted to do this with us, not actually sure if we could involve him in a school project. But we didn't care because we're rebels.
That's what we are: rebels.

We assigned different parts of the projects to each other. Robert was going to do the Design. Daniel was to implement it and I would be doing all the backend work. In agreement we decided to use Websockets to communicate between frontend and backend, enabling real-time status updates.

The Raspberry Pi we would install would dispatch REST-API calls to bigpoopdata.com and there the backend would store it in an sqlite database, later it would do simple statistical analyses (all in javascript because I'm an idiot) to send them to the frontend on demand.

::row{justify-content=center}
![Raspberry Pi](/img/works/bpd/pi.jpg)
::

Two months later we had the website up and running, just in time for the application deadline for Ars Electronica. (Although we did make a few adjustments afterwards.)

![Website](/img/works/bpd/website.png)

## Ars Electronica Festival

A few weeks went by and we got the word that the jury had taken a liking to our project and wanted to give us the Netidee Spezial Prize. Still laughing about the sweet absurdity of the whole thing we set out to build a physical component for the website which we could exhibit at the Ars Electronica Festival.

::row{justify-content=center}
![Building The Tank](/img/works/bpd/building_tank.jpg)
::

The device consisted of a touchscreen with a computer inside of a toilet tank. The festival visitors could flush the toilet tank to open or close the virtual toilet door.
A few last-minute fixes were required on-site.

::row{justify-content=center}
![Last Minute Fixes](/img/works/bpd/nico_fixing.jpg)
::
