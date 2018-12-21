Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaKZn-0004tL-BP
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaKZe-00010O-RN
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:49124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gaKZe-0000zc-AU
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:10:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gaKZc-0003Bo-UR
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:10:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E16162E8019
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Dec 2018 13:02:45 -0000
From: zhaoby <1809453@bugs.launchpad.net>
Reply-To: Bug 1809453 <1809453@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154539736525.20217.16347056739487632712.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809453] [NEW] Windows qemu download Big file bug
 in net user mode
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

hi

Windows qemu with -net user downloading big files has a bug, -net tap is
good!

I suspect that the Slirp protocol has a bug on the Windows pc, which is
normal on ubuntu.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809453

Title:
  Windows  qemu download Big file bug in net user mode

Status in QEMU:
  New

Bug description:
  hi

  Windows qemu with -net user downloading big files has a bug, -net tap
  is good!

  I suspect that the Slirp protocol has a bug on the Windows pc, which
  is normal on ubuntu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809453/+subscriptions
