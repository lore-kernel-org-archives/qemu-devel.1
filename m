Received: from eggs.gnu.org ([2001:4830:134:3::10]:51973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZCwi-00020b-0Z
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZCwe-0006Qs-SW
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:40:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:46524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cZCwe-0006QZ-Mm
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:40:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cZCwd-0006m1-KL
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 08:40:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 988CA2E80C4
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 08:40:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Feb 2017 08:34:19 -0000
From: Uqbar <1661176@bugs.launchpad.net>
Reply-To: Bug 1661176 <1661176@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170202083419.1225.82778.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1661176] [NEW] [2.8.0] Under VNC CTRL-ALT-2
 doesn't get to the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

With version 2.6.2 I could access the monitor via VNC by pressing CTRL-ALT-=
2, while CTRL-ALT-3 brought me to the "serial0 console". CTRL-ALT-1 brought=
 me back to the VGA console.
Since 2.8.0 CTRL-ALT-2 brings me to the "serial0 console" and CTRL-ALT-3 to=
 the "parallel0 console". The monitor is not available any more, to any CTR=
L-ALT-1stROW.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661176

Title:
  [2.8.0] Under VNC CTRL-ALT-2 doesn't get to the monitor

Status in QEMU:
  New

Bug description:
  With version 2.6.2 I could access the monitor via VNC by pressing CTRL-AL=
T-2, while CTRL-ALT-3 brought me to the "serial0 console". CTRL-ALT-1 broug=
ht me back to the VGA console.
  Since 2.8.0 CTRL-ALT-2 brings me to the "serial0 console" and CTRL-ALT-3 =
to the "parallel0 console". The monitor is not available any more, to any C=
TRL-ALT-1stROW.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661176/+subscriptions
