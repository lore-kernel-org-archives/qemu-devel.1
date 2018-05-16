Received: from eggs.gnu.org ([2001:4830:134:3::10]:47510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fIo5e-000767-HD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 00:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fIo5Z-0005w7-K4
	for qemu-devel@nongnu.org; Wed, 16 May 2018 00:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:49564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fIo5Z-0005vu-DK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 00:30:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fIo5Y-0005kP-Cf
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 04:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E6602E806E
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 04:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 May 2018 04:17:25 -0000
From: Launchpad Bug Tracker <1435101@bugs.launchpad.net>
Reply-To: Bug 1435101 <1435101@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150323004114.9810.22436.malonedeb@soybean.canonical.com>
Message-Id: <152644424545.8017.14324359342670801100.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1435101] Re: Windows,
 QEMU 2.2.50 fails to boot XP CD
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
https://bugs.launchpad.net/bugs/1435101

Title:
  Windows, QEMU 2.2.50 fails to boot XP CD

Status in QEMU:
  Expired

Bug description:
  Running XP Pro SP3 host 32bit.  When I launch qemu booting from CD, it fa=
ils to complete load, getting stuck at "Setup is starting Windows". It does=
 not proceed past. I tried to disable floppy but still no go. Download olde=
r version 1.5.1-win32, 0.9.1, same problem. =

  qemu-system-i386w.exe -cdrom "d:\XP.ISO" -hda d:\xp.img -boot d =

  with -global isa-fdc.driveA=3Dc or -no-fd-bootchk switches but no go. I s=
ee others have run into this problem as well but no real solutions. Some fo=
lks says turning off floppy works and I tried.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1435101/+subscriptions
