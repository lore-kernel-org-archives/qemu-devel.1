Received: from eggs.gnu.org ([2001:4830:134:3::10]:48424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5sC-0005Ws-9E
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5s9-0001AP-8b
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:54:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:35103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT5s9-0001AG-2k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:54:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT5s7-0007PP-LZ
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:54:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7864F2E80CB
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:54:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 11:43:30 -0000
From: Thomas Huth <1194954@bugs.launchpad.net>
Reply-To: Bug 1194954 <1194954@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130626165108.26069.67113.malonedeb@soybean.canonical.com>
Message-Id: <20170116114330.27164.29988.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1194954] Re: Windows 95 guest reboots itself on
 qemu 1.5.0 & 1.5.50 (GIT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently v2.8)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1194954

Title:
  Windows 95 guest reboots itself on qemu 1.5.0 & 1.5.50 (GIT)

Status in QEMU:
  Incomplete

Bug description:
  When I begin to run a Windows 95 guest on these releases of qemu, it
  reboots itself more times without my permission (eg. without shutting
  it down properly), and when I'm installing Netscape 4.08 at, for
  example, 46% or 75%, it still reboots itself without completing the
  installation of the web browser. Is this an issue of main-loop.c?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1194954/+subscriptions
