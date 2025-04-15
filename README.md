# Site Link

[![build and deploy documentation site](https://github.com/Arian04/masm-tools-web/actions/workflows/pages.yml/badge.svg)](https://github.com/Arian04/masm-tools-web/actions/workflows/pages.yml)

https://arian04.github.io/masm-tools-web/


## What is this?

This is the landing page for several useful MASM projects or websites.
It's meant as a resource for students being taught MASM in a course.
For this reason, everything here is written with the 8th edition of
"Assembly Language for x86 Processors" by Kip Irvine in mind. If you aren't
using that textbook, some of these resources may not be relevant to you.

The site for the textbook mentioned above can be found at http://www.asmirvine.com/

## What's in this repo specifically?

The website files + a Dockerfile to create HTML-ified documentation for
the Irvine library. The [original file](http://www.asmirvine.com/files/IrvineLibHelp.exe) is
distributed as a self-extracting EXE file that contains a CHM file.
I decided to host it to make it easier for people to access it.

The site is deployed using Github Actions + Github Pages, so if that file is
ever updated (which I doubt will happen, since it was last modified in 2005),
then all I need to do is update the file's checksum and everything will re-deploy.
So if this happens, feel free to create an issue or pull request.
