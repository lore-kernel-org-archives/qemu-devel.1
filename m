Received: from eggs.gnu.org ([2001:4830:134:3::10]:49693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cY3bx-0008HG-Bz
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cY3bu-0004mu-6z
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:42530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cY3bt-0004ly-Vi
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cY3bs-0004Ym-BT
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:30:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46B2D2E80CA
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:30:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2017 04:17:33 -0000
From: Launchpad Bug Tracker <1186935@bugs.launchpad.net>
Reply-To: Bug 1186935 <1186935@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130603094125.27500.39759.malonedeb@gac.canonical.com>
Message-Id: <20170130041734.7435.92502.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1186935] Re: [1.5] QEMU monitor gets overlapped
 by GTK menu bar
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
https://bugs.launchpad.net/bugs/1186935

Title:
  [1.5] QEMU monitor gets overlapped by GTK menu bar

Status in QEMU:
  Expired

Bug description:
  The QEMU minitor gets partially hidden by the menu bar which was
  introduced in QEMU version 1.5.0.

  Steps to reproduce:

   1. Run `qemu-system-x86_64`
   2. Press Ctrl + Alt + 2 (or use the menu bar)
   3. Observe that the monitor output is partially shown, without the "comp=
at_monitor0 console" and "QEMU 1.5.0 monitor - type 'help' for more informa=
tion" lines.

  Attached is a screenshot of `qemu-system-x86_64` and `qemu-system-
  x86_64 -display sdl`.

  Version: 1.5.0
  Distribution: Arch Linux 64-bit

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1186935/+subscriptions
