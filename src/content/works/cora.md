---
date: 2020-04-26
title: cora
subtitle: Decoding Canon Raw Files

image: /img/works/cora/main.png
headerImage: /img/works/cora/header.png

links: 
  - title: cora on Github
    icon: mdiGithub
    url: https://github.com/meksor/cora

categories:
  - Software
---

## What is a "raw" camera file?

Most consumer cameras will (if not told otherwise) save `.png` or `.jpg` files to the digital storage medium of your choice. This is already a heavily post-processed version of the image however and can in certain situations limit the amount of options you have while editing the image afterwards.

This is why camera vendors will offer the ability (at least in pro-sumer and professional products) to save the raw sensor data to an image file.
This file stores not only raw sensor data but also a colored jpeg thumbnail, EXIF data like location, exposure, apt., iso, date and time, which optic was used and much more.

This allows us to choose post-sensor algorithms (like de-bayering, chr. abberation correction, optic correction and so on) when we get back home to our computer, not while we are looking at a 5cm screen in the field. 

## Canon's CR2

I found a complete specification [on the archive](https://web.archive.org/web/20140219063611/http://wildtramper.com/sw/cr2/cr2.html). 
[This page](http://lclevy.free.fr/cr2/) was also very helpful.
In short, a CR2 file is a TIFF file with multiple layers (**IFD**s) . From the link:

```
* The Canon CR2 file format is an encapsulated TIFF shell having 4 IFD sets.
* These IFDs are different versions of the same image.
*
*	  +=====================================+ Start of TIFF/CR2 file
*	  | TIFF Header 			|
*	  | Size = 8				|
*	  +=====================================+
*	  | Various TIFF Tags describing File	| IFD #1 Segment
*	  |   EXIF (TIFF subdirectory)		| Canon 5D image size 2496x1664
*	  |- - - - - - - - - - - - - - - - - - -|
*	  | JPEG data (baseline compression)	|
*	  +=====================================+
*	  | JpegInterchangeFormat		| IFD #2 Segment
*	  |					| unknown image size
*	  |- - - - - - - - - - - - - - - - - - -|
*	  | JPEG Compressed data		|
*	  +=====================================+
*	  | Few TIFF Tags describing segment	| IFD #3 Segment
*	  |					| Canon 5D image size 384x256
*	  |- - - - - - - - - - - - - - - - - - -|
*	  | JPEG data (unknown compression)	|
*	  +=====================================+
*	  | Few TIFF Tags describing segment	| IFD #4 Segment - RAW image
*	  |					| Canon 5D image size 4476x2954
*	  |- - - - - - - - - - - - - - - - - - -|
*	  | JPEG data (lossless compression)	|
*	  +=====================================+
```

The fourth IFD is the one we want to decode, it holds the raw and losslessly compressed sensor data. The data is scrambled (probably read in parallel at multiple points in the sensor chip) and encoded in an off-spec, lossless jpeg format. See also [this very useful visual represenation of that JPEG format](https://raw.githubusercontent.com/lclevy/libcraw2/refs/heads/master/docs/cr2_lossless.pdf).

~300 lines of C++ later we can render the sensor data as a greyscale image:

::row{justify-content=center}

![Decoded File](/img/works/cora/raw.jpg){width=750px}

::

## Debayering

I stopped at this point because I got distracted by something else. 
Thankfully there is projects like [libcraw2](https://github.com/lclevy/libcraw2) you can use instead.