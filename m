Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1gGkMx-0006yK-Jr
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1gGkMs-0002Wo-F2
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:39 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1gGkMs-0002TP-7o
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:34 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
	by outpost.zedat.fu-berlin.de (Exim 4.85)
	for qemu-devel@nongnu.org with esmtps
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id <1gGkMo-002Cbp-FT>; Sun, 28 Oct 2018 13:40:30 +0100
Received: from x4db36b05.dyn.telefonica.de ([77.179.107.5] helo=[192.168.1.8])
	by inpost2.zedat.fu-berlin.de (Exim 4.85)
	for qemu-devel@nongnu.org with esmtpsa (TLSv1.2:AES128-SHA:128)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id <1gGkMo-002Q9t-4d>; Sun, 28 Oct 2018 13:40:30 +0100
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <9179e8bc-1b89-1ed3-687a-467fc45797e0@physik.fu-berlin.de>
Date: Sun, 28 Oct 2018 13:40:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] bochs-display and the future of VGA support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi!

I just happened to read Gerd Hoffmann's post on the bochs-display [1] dri=
ver
and was wondering what the future plans for VGA support are.

Phoronix makes it sound like [2] that VGA support for guests is supposed =
to
be removed which I find hard to believe. Since once VGA support is gone,
QEMU would no longer be able to run older operating systems which is one =
of
the key features of an emulator in my opinion.

Can anyone tell me what the plans are?

PS: I'm subscribed to the list, but currently don't receive any mailing
    list mail due to the high volume. So please CC me in your reply.

Thanks,
Adrian

> [1] https://www.kraxel.org/blog/2018/10/qemu-vga-emulation-and-bochs-di=
splay/
> [2] https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DQEMU-Legacy=
-Free-Display

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
