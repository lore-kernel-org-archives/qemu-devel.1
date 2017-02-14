Received: from eggs.gnu.org ([2001:4830:134:3::10]:55186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlZ-0003QN-5O
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlW-0001Jo-FA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:57881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdUlW-0001J0-AE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:30:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdUlV-00048f-1K
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C23962E80C9
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 04:17:43 -0000
From: Launchpad Bug Tracker <906864@bugs.launchpad.net>
Reply-To: Bug 906864 <906864@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111220125027.32548.5381.malonedeb@gac.canonical.com>
Message-Id: <20170214041743.28611.90857.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 906864] Re: Always mouse grabbing with -usbdevice
 tablet
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
https://bugs.launchpad.net/bugs/906864

Title:
  Always mouse grabbing with -usbdevice tablet

Status in QEMU:
  Expired

Bug description:
  version: QEMU emulator version 1.0 (qemu-kvm 1.0)
               QEMU emulator version 1.0 (qemu 1.0)
               (source builds)
  os: archlinux x86-64
  last working version: qemu-kvm 0.15.1

  commandline: each with "-usb -usbdevice tablet" and sdl output

  expected behavior:  mouse gets grabbed only by forcing it (pressing
  release/grab-combination (CTRL-ALT))

  actual behavior:
  When moving the mouse over the window it gets instantly grabbed, so i can=
not use window-manager-specific hotkeys anymore.  After pressing the releas=
e combination every mouse movement over or within the window will grab the =
mouse again. =

  I have tried this with several vga types and window managers: no differen=
ce

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/906864/+subscriptions
