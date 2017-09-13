Received: from eggs.gnu.org ([2001:4830:134:3::10]:40891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2Nz-0000yK-TZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2Nw-0002rg-0w
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:41403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds2Nv-0002qa-QP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:46:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds2Ns-0002Dd-C2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:46:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ECFB52E84A4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:46:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:29:50 -0000
From: Thomas Huth <1300863@bugs.launchpad.net>
Reply-To: Bug 1300863 <1300863@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140401155311.5581.73703.malonedeb@chaenomeles.canonical.com>
Message-Id: <150528779068.5685.1472662207390371591.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1300863] Re: Qemu does not show all files on
 floppy or hard drive (MS DOS 6.22 guest)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** No longer affects: qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1300863

Title:
  Qemu does not show all files on floppy or hard drive (MS DOS 6.22
  guest)

Status in qemu package in Debian:
  New

Bug description:
  My host system is a raspberry pi model B 512MB. To start qemu I typed int=
o lxterminal:
    =

  qemu-system-i386 -hda qemu.img -Fda Dos622-1.img -boot a

  Qemu version 1.7.0+dfsg-3 installed as package. The DOS disks were
  downloaded from winworldpc.com and if I mount them under Linux I see
  all the files, but on qemu I see the first 3 files only. The hard
  drive image I am using is a 30MB flat image created using bximage.

To manage notifications about this bug go to:
https://bugs.launchpad.net/debian/+source/qemu/+bug/1300863/+subscriptions
