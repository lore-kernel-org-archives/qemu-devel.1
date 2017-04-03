Received: from eggs.gnu.org ([2001:4830:134:3::10]:38735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cutdP-0001u4-AY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 00:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cutdM-0007GC-8M
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 00:30:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:48216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cutdM-0007FD-2K
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 00:30:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cutdK-0004ko-Eq
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:30:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9DD682E80E6
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 04:30:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Apr 2017 04:17:21 -0000
From: Launchpad Bug Tracker <1252010@bugs.launchpad.net>
Reply-To: Bug 1252010 <1252010@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131117135926.19947.91012.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170403041721.29960.80965.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1252010] Re: can't assign enough RAM to the VM
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
https://bugs.launchpad.net/bugs/1252010

Title:
  can't assign enough RAM to the VM

Status in QEMU:
  Expired

Bug description:
  QEMU version: 1.6.90.0 from 2013 11 16
  Host OS: Windows XP SP3 x86
  Host machine: 3.2 GHz AMD Athlon 64 dual core processor, 4 GB DDR II (3.2=
 seen by the OS) memory
  Guest OS: Grub4Dos boot manager menu
  Problem: you can't assign more than 880 MB memory to the VM, although wit=
h 0.15.1.0 version you can assign up to 1179 MB.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1252010/+subscriptions
