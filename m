Received: from eggs.gnu.org ([2001:4830:134:3::10]:36314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWahe-0007NN-Cr
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWaha-0007kd-Fp
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:30:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:50432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWaha-0007j3-9u
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:30:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWahW-0005ze-A6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 28D292E80D5
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jan 2018 04:17:20 -0000
From: Launchpad Bug Tracker <1188018@bugs.launchpad.net>
Reply-To: Bug 1188018 <1188018@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130606060816.21214.71277.malonedeb@chaenomeles.canonical.com>
Message-Id: <151495304108.5160.14790791030375464676.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1188018] Re: qemu monitor does not suppot rbd
 "savevm" command
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
https://bugs.launchpad.net/bugs/1188018

Title:
  qemu monitor does not suppot rbd "savevm" command

Status in QEMU:
  Expired

Bug description:
  1. I used ceph rbd as my block device, /usr/local/bin/qemu-system-
  x86_64 -drive
  format=3Drbd,file=3Drbd:rbd/sles.img:rbd_cache=3Dtrue,cache=3Dwriteback -=
boot
  c  -m 1024 -enable-kvm -vnc 0.0.0.0:0 -monitor stdio

  2. when in monitor command line "savevm", it reports "Error -95 while
  writing VM" in the monitor

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1188018/+subscriptions
