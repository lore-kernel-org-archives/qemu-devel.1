Received: from eggs.gnu.org ([2001:4830:134:3::10]:44189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1edsem-0006rI-8m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 02:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1edseh-0004EN-BB
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 02:06:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:51788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1edseh-0004Dj-59
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 02:06:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1edseg-0008FL-5Y
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 07:06:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 27BB72E806E
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 07:06:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2018 06:53:57 -0000
From: Thomas Huth <1176366@bugs.launchpad.net>
Reply-To: Bug 1176366 <1176366@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130504161319.14721.75130.malonedeb@gac.canonical.com>
Message-Id: <151669043740.19986.1353369967284689653.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1176366] Re: TCPIP not working on qemu 1.4.50
 (master)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1176366

Title:
  TCPIP not working on qemu 1.4.50 (master)

Status in QEMU:
  Incomplete

Bug description:
  whenever I try, in the guest OS, in this case it's NT 3.1, to enable
  TCP/IP, it crashes the whole emulator. With either the ne2000 isa,
  ne2000 pci or PCnet, still crashes

  below is attached a screenshot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1176366/+subscriptions
