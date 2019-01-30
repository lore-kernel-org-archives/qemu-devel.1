Received: from eggs.gnu.org ([209.51.188.92]:45483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gohVn-00040K-M2
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 23:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gohVm-0007Ly-VJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 23:30:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:54224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gohVm-0007Jf-Q7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 23:30:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gohVl-0007q1-03
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 04:30:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF9052E8031
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 04:30:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Jan 2019 04:17:21 -0000
From: Launchpad Bug Tracker <1519037@bugs.launchpad.net>
Reply-To: Bug 1519037 <1519037@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151123171133.3457.55727.malonedeb@chaenomeles.canonical.com>
Message-Id: <154882184183.25911.11869736945539536867.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1519037] Re: qemu-i386 32-bit segfault
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
https://bugs.launchpad.net/bugs/1519037

Title:
  qemu-i386 32-bit segfault

Status in QEMU:
  Expired

Bug description:
  I'm getting segfaults on 32-bit linux trying to run binaries using
  qemu-i386 from git. These segfaults go away when run in gdb or strace
  - could it be about the environment somehow?

  In contrast qemu-x86_64 works fine. How can I pinpoint the cause of
  this?

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1519037/+subscriptions
