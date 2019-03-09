Received: from eggs.gnu.org ([209.51.188.92]:55824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2TdR-0001Re-K3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2TdQ-00018o-KS
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:48738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2TdQ-00017v-E8
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 23:30:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2TdP-000101-JH
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 04:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C1082E80D0
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 04:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Mar 2019 04:17:34 -0000
From: Launchpad Bug Tracker <1530386@bugs.launchpad.net>
Reply-To: Bug 1530386 <1530386@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151231192039.26257.96801.malonedeb@gac.canonical.com>
Message-Id: <155210505473.19923.18355888952958030384.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1530386] Re: command.com on win95 throws video
 mode out
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
https://bugs.launchpad.net/bugs/1530386

Title:
  command.com on win95 throws video mode out

Status in QEMU:
  Expired

Bug description:
  on a presumed-good copy of Windows 95 obtained from http://forum.xda-
  developers.com/showthread.php?t=3D1960870, the operating system boots
  successfully and shows up fine, but as soon as I double-click the MS-
  DOS icon, the window, while remaining the same size, goes to a
  different resolution and only shows a small portion of what it did,
  with strange colors and artifacts. tried first with the Debian 2.5
  package, then with latest cvs sources, then with the 2.5.0 release,
  all the same problem.

  jcomeau@aspire:/usr/src/qemu-2.5.0/build$ cd /tmp/win95/SDL/
  jcomeau@aspire:/tmp/win95/SDL$ /usr/src/qemu-2.5.0/build/i386-softmmu/qem=
u-system-i386 c.img =

  jcomeau@aspire:/tmp/win95/SDL$ /usr/src/qemu-2.5.0/build/i386-softmmu/qem=
u-system-i386 --version
  QEMU emulator version 2.5.0, Copyright (c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1530386/+subscriptions
