Received: from eggs.gnu.org ([2001:4830:134:3::10]:43978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dh71u-0005sl-GB
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dh71o-0001TU-M4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:31:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:36231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dh71o-0001TA-G7
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:31:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dh71l-0006nI-DH
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 04:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E98392E80E1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 04:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Aug 2017 04:17:44 -0000
From: Launchpad Bug Tracker <1096713@bugs.launchpad.net>
Reply-To: Bug 1096713 <1096713@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130107012007.1165.17085.malonedeb@gac.canonical.com>
Message-Id: <150268426413.12227.6859791495575558969.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1096713] Re: qemu 1.3.0: Windows XP crashes when
 reconizing the USB keyboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1096713

Title:
  qemu 1.3.0: Windows XP crashes when reconizing the USB keyboard

Status in QEMU:
  Expired

Bug description:
  I'm trying to use the usb tablet and the usb keyboard as follows:
  ./qemu-system-i386  -device pci-ohci -device usb-tablet -device usb-kbd
  or
  ./qemu-system-i386  -device ich9-usb-ehci1 -device ich9-usb-uhci1 -device=
 usb-tablet -device ich9-usb-uhci2 -device usb-kbd

  While Windows XP works fine if I only use the tablet but not the
  keyboard, it crashed with a BSOD when I use both keyboard and tablet.
  It crashed during the detection of the keyboard.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1096713/+subscriptions
