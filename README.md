   Copyright (c) 2009 Lennart Melzer

   Permission is hereby granted, free of charge, to any person
   obtaining a copy of this software and associated documentation
   files (the "Software"), to deal in the Software without
   restriction, including without limitation the rights to use,
   copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the
   Software is furnished to do so, subject to the following
   conditions:

   The above copyright notice and this permission notice shall be
   included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
   OTHER DEALINGS IN THE SOFTWARE.


Transmissionair
===============

A simple remote control for Transmission. Running with Adobe Air.

Intention
-----
This piece of software does not imply to replace the real BitTorrent-Client [Transmission](http://transmissionbt.com) but rather provide an desktop application that remote controls the `transmission-daemon` through its RPC-Interface. I wanted to start/stop and add/remove Torrents from each of my home computers with features like **Drag and Drop** and the _desktop app_-Feeling, while running a single transmission-daemon on our home server. The Webinterface supplied with Transmission does its work, but right now it lacks the mentioned features I want.

Warning
-------
This is alpha-Software. It is neither feature complete, nor is it fully tested. Core features like adding/removing as well as starting/pausing Torrents _should_ work. Simple **Drag and Drop**-Support for adding Torrents is already implemented. The Server Chooser is _really_ bare metal, don't expect it to _manage_ anything.

Requirements
------------
* Flex 4 SDK
* Air 2 Beta SDK
* FlashBuilder (not necessarily, but should be easier to compile)

Dependencies
--------
The [as3corelib](http://code.google.com/p/as3corelib/)

Installation
-----
Clone the repository and load it up into FlashBuilder. Compile. Pray that it works!

Future
------
I am not planning on integrating a lot of other features, since the fully featured Desktop Clients (or even the Webinterface) do their job really good. One thought I had might be interesting since the Air 2 SDK will support spawning native processes: An embedded transmission-daemon to have a Windows-compatible version of Transmission. I don't know how far the C#-Version is right now, but until then this might be a nice alternative.
