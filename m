Received: from eggs.gnu.org ([209.51.188.92]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hKbXm-0004B5-VC
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 00:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hKbSl-0005cW-Hs
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 00:30:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:54372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hKbSl-0005cG-Ci
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 00:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hKbSk-0007mn-0g
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF6862E8060
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 04:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Apr 2019 04:17:20 -0000
From: Launchpad Bug Tracker <1556044@bugs.launchpad.net>
Reply-To: Bug 1556044 <1556044@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160311113437.1236.81872.malonedeb@gac.canonical.com>
Message-Id: <155642504101.20856.8680258730787593942.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1556044] Re: Redox GUI hangs with 100% CPU on ARM
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
https://bugs.launchpad.net/bugs/1556044

Title:
  Redox GUI hangs with 100% CPU on ARM

Status in QEMU:
  Expired

Bug description:
  Booting into Redox OS cli on ARM with qemu-system-i386 works fine.
  However, starting the Redox GUI (orbital) brings up the graphical
  interface and then starts using 100% CPU. I'd guess it's related to
  mouse detection and handling.

  The OS image is fully usable on x86.

  =

  https://www.dropbox.com/s/u6v2k9wzcuiycfo/redox-disk.img.xz?dl=3D0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1556044/+subscriptions
