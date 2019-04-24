Received: from eggs.gnu.org ([209.51.188.92]:59154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ9dG-0002IL-T7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ9Ys-0002yq-6k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:31:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:59668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJ9Yq-0002vb-ES
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:31:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJ9Yp-0007bB-BL
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:31:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 51FCD2E806F
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:31:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 04:17:36 -0000
From: Launchpad Bug Tracker <1552549@bugs.launchpad.net>
Reply-To: Bug 1552549 <1552549@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160303051444.1816.68596.malonedeb@gac.canonical.com>
Message-Id: <155607945638.22348.12682671048177165153.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1552549] Re: qemu-system-i386 verison 2.5.50
 fails at lmsw instruction
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
https://bugs.launchpad.net/bugs/1552549

Title:
  qemu-system-i386 verison 2.5.50 fails at lmsw instruction

Status in QEMU:
  Expired

Bug description:
  I cloned qemu source code from github.com, and compiled it on my
  Kubuntu 15.10 laptop to run my little OS. When booting my little OS,
  the virtual machine's screen keep blinking, I guess it's the virtual
  machine rebooting on and on automatically for some unknown reason, but
  there is no further information shown on Kubuntu's terminal. I'm
  pretty sure this problem is not caused by my little OS, because it
  works just fine in qemu-system-i386 version 2.5.0.

  I debugged my OS and find this problem happens when executing
  instruction "lmsw ax". Is this a bug, can anyone help me out?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1552549/+subscriptions
