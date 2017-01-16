Received: from eggs.gnu.org ([2001:4830:134:3::10]:52918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT6M0-0001Ub-7B
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT6Lv-0003TB-8f
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:25:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:48680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT6Lv-0003T0-3Y
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:25:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT6Lu-0001b8-0m
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:25:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E1F552E80CA
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:25:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 12:13:31 -0000
From: Thomas Huth <1568356@bugs.launchpad.net>
Reply-To: Bug 1568356 <1568356@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160409185053.32096.47206.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170116121332.14666.94963.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1568356] Re:
 ERROR:ui/sdl2-2d.c:120:sdl2_2d_switch:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 435deffefbb07d9a0cafef4 has been released with QEMU v2.7.0
already

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1568356

Title:
  ERROR:ui/sdl2-2d.c:120:sdl2_2d_switch:

Status in QEMU:
  Fix Released

Bug description:
  when display sdl is selected  in display switch resolution qemu exit
  with a core dump with this message

  =

  ERROR:ui/sdl2-2d.c:120:sdl2_2d_switch: code should not be reached

  My Machine is a Cyrus+ PowerPc P5020 4gb ram Radeon 6570 2Gb

  This issue affected PowerMac G5 quad too .

  My distro is Mate 16.04

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1568356/+subscriptions
