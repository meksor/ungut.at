---
date: 2018-05-30
title: Hexabition
subtitle: |
    "die Graphische" Gradutation Exhibition

image: /img/works/hexabition/main.png
headerImage: /img/works/hexabition/header.png

links: 
  - title: |
        "die Graphische" Website
    icon: mdiOpenInNew
    url: https://www.graphische.net/fotografie-news/hexabition-5-jahre-6-eckeneine-ausstellung-der-5-multimedia/

categories:
  - Art
  - Installation
---

## Huh?

Hexabition was the gradute exhibition at "Die Graphische". The class was divided into four groups architecture (3D), animation, graphic design (interfacedesign) and technology.

I was in charge of the technology team and responsible for writing code aswell as designing the system. The plan was to have a few tablets in a hexagonal maze to show off the projects we had finished over the last 5 years. Ultimately the tablets ran an android app which packaged a website, containing the projects of about 4 people on one tablet. The tablet would talk to ESP8266 LED controller boards that controlled the lighting in each individual cell over MQTT. If the beholder clicked on one of the people in the interface, the lights in that cell would react.

::row{justify-content=center}

::video{controls class="shadow hoverable" width=750px}
:::source{src=/img/works/hexabition/walkthrough.mp4}
::::
::

::

We wrote a bundling script to bundle the website for each tablet, and told the gradle build system to build all versions of the app at once with the appropriate files and deployed the apps to the tablet using some proprietary Samsung mechanism.

The project was very stressful due to time constraints but every team did their job well.

::row{justify-content=center}
![Scaffold](/img/works/hexabition/scaffold.jpg)
::

