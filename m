Received: from eggs.gnu.org ([2001:4830:134:3::10]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlZ-0003QJ-3k
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlW-0001JA-0h
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:57841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdUlV-0001IO-S1
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:30:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdUlT-000411-Ea
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 518F32E818A
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 04:17:44 -0000
From: Launchpad Bug Tracker <922355@bugs.launchpad.net>
Reply-To: Bug 922355 <922355@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120126230832.17738.52994.malonedeb@soybean.canonical.com>
Message-Id: <20170214041744.28611.60940.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 922355] Re: qemu crashes when invoked on
 Pandaboard
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
https://bugs.launchpad.net/bugs/922355

Title:
  qemu crashes when invoked on Pandaboard

Status in QEMU:
  Expired

Bug description:
  root@omap:~# uname -a
  Linux omap 3.1.6-x6 #1 SMP Thu Dec 22 11:17:51 UTC 2011 armv7l armv7l
  armv7l GNU/Linux

  root@omap:~# qemu
  Could not initialize KVM, will disable KVM support
  /build/buildd/qemu-kvm-0.14.1+noroms/tcg/arm/tcg-target.c:848: tcg fatal =
error

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/922355/+subscriptions
