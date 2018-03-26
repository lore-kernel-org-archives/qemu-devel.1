Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0L1i-0007j5-TL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 01:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0L1f-0003FN-S1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 01:50:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:42602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f0L1f-0003F6-MM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 01:50:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f0L1e-0001Ym-8C
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 05:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 352502E80C0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 05:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Mar 2018 05:38:41 -0000
From: Erik Kristian Sverre Uri <1758819@bugs.launchpad.net>
Reply-To: Bug 1758819 <1758819@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152204272199.688.3778854075369133494.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1758819] [NEW] HVF Illegal instruction: 4,
 High Sierra, v2.12-rc0
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

I've built v2.12.0-rc0 on MacOS using homebrew. I'm running 10.13.3 on a
5,1 Mac Pro with a X5690 processor.

When I run 'qemu-system-x86_64 -M accel=3Dhvf', I get a crash "Illegal
instruction: 4".

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: hvf macos

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1758819

Title:
  HVF Illegal instruction: 4, High Sierra, v2.12-rc0

Status in QEMU:
  New

Bug description:
  I've built v2.12.0-rc0 on MacOS using homebrew. I'm running 10.13.3 on
  a 5,1 Mac Pro with a X5690 processor.

  When I run 'qemu-system-x86_64 -M accel=3Dhvf', I get a crash "Illegal
  instruction: 4".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1758819/+subscriptions
