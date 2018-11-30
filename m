Received: from eggs.gnu.org ([2001:4830:134:3::10]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSePX-0000en-9M
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSeHB-0006l5-67
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:35:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:49874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gSeHA-0006ku-Vw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:35:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gSeH9-0002vK-Sa
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:35:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CA6C02E805B
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:35:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Nov 2018 08:21:24 -0000
From: Thomas Huth <1519037@bugs.launchpad.net>
Reply-To: Bug 1519037 <1519037@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151123171133.3457.55727.malonedeb@chaenomeles.canonical.com>
Message-Id: <154356608437.15228.7775018245950425163.malone@soybean.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1519037

Title:
  qemu-i386 32-bit segfault

Status in QEMU:
  Incomplete

Bug description:
  I'm getting segfaults on 32-bit linux trying to run binaries using
  qemu-i386 from git. These segfaults go away when run in gdb or strace
  - could it be about the environment somehow?

  In contrast qemu-x86_64 works fine. How can I pinpoint the cause of
  this?

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1519037/+subscriptions
