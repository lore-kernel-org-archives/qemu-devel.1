Received: from eggs.gnu.org ([2001:4830:134:3::10]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1enLwG-0001V1-Em
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 05:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1enLwF-0002MG-NH
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 05:11:20 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:35472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1enLwF-0002MA-Hl
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 05:11:19 -0500
Received: by mail-ot0-x22b.google.com with SMTP id p8so3440233otf.2
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 02:11:19 -0800 (PST)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 18 Feb 2018 11:11:18 +0100
Message-ID: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Qemu SDL2 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Hi,

I'd like to report a bug when using the SDL2 GUI in both Linux and
Windows, which can be observed with in my case latest qemu-system-ppc
running parallel instances of OSX 10.4 and 10.3.

After switching back and forth between GUIs, dragging becomes copying,
keyboard starts using a strange character set.
An additional "Alt" key press is needed to restore normal behaviour.

Best regards,
Howard
