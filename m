Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gMXfX-0007uh-93
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gMXfV-0004GO-Dn
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:19:46 -0500
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <87eb5ae8-5008-b93f-6072-add50367b105@tuxfamily.org>
Date: Tue, 13 Nov 2018 13:19:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] QEMU Advent Calendar 2018 - Help wanted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Kashyap Chamarthy <kashyapc@fedoraproject.org>, Richard Jansson <richard.j.jansson@gmail.com>


 Hi all!

This year, we are celebrating the 15th anniversary of QEMU [1] - to do
so, we would like to perform another edition of the QEMU Advent Calendar.

If you didn't see the previous QEMU Advent Calendars yet, please visit
the website and have a look at the editions from 2014 and 2016 (which
can be selected in the menu at the top):

  https://www.qemu-advent-calendar.org/

This year, too, the QEMU Advent Calendar 2018 will be a website that
reveals a new disk image for download each day in December until the
holiday season starts. Launching the disk image under QEMU will bring up
a nice surprise!

But to be able to make this happen, we need help from people who
- have ideas for disk images
- would like to prepare one or more disk images.
Ideally, you have an idea for a disk image and also prepare it yourself.
But we also are glad to get just the ideas, or help from people who
would like to prepare a disk image with the idea from somebody else!

Possible ideas (others are welcome of course, too):
- Showcase a new feature that has been added to QEMU recently
- Package your favorite freeware DOS game from your childhood
  (must be freely redistributable, so e.g. use FreeDOS as OS)
- Know a fancy new or old freely available Operating System which
  we did not feature in the previous advent calendars yet?
- Any cool self-made firmware or extensions to existing firmware
  that runs in QEMU.
- It would also be great to get some more images for non-x86 targets,
  so if you know something usable, please speak up!

Disk image requirements:
 * We need 24 disk images (for the first 24 days of December)
 * Content must be freely redistributable (i.e. no proprietary
   license that prevents distribution). For GPL based software,
   you need to provide the source code, too.
 * Provide a name and a short description of the disk image
   (e.g. with hints on what to try)
 * Provide a ./run shell script that prints out the name and
   description/hints and launches QEMU
 * Provide a screenshot/image/logo for the website
   (preferred resolution of the image is 320x240)
 * Size should be ideally under 100 MB per disk image
   (but if some few images are bigger, that should be OK, too)

Are you interested in participating? Then please reply to this email
(off-list if you do not want to spoil your idea for disk images).

Or do you have questions? Then feel free to reply or ask on the #qemu
channel on irc.oftc.net, too.

 Thomas


PS: The QEMU Advent Calendar 2018 is a secular calendar (not
religious). The idea is to create a fun experience for the QEMU
community which can be shared with everyone, and to celebrate the 15th
anniversary of QEMU. You don't need to celebrate Christmas or another
religious festival to participate!

[1] According to the following mail, QEMU 0.1 was announced in March
2003: https://www.winehq.org/pipermail/wine-devel/2003-March/015577.html
