Received: from eggs.gnu.org ([2001:4830:134:3::10]:56629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLLut-0005dr-Nw
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eLLup-0007P5-PK
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:30:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eLLup-0007Oj-JD
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:30:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eLLul-0002mu-6m
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 04:30:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C8D02E81A6
	for <qemu-devel@nongnu.org>; Sun,  3 Dec 2017 04:29:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Dec 2017 04:17:20 -0000
From: Launchpad Bug Tracker <1318474@bugs.launchpad.net>
Reply-To: Bug 1318474 <1318474@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140512042017.23765.60559.malonedeb@wampee.canonical.com>
Message-Id: <151227464100.17805.10388382583617973860.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1318474] Re: QEMU update causes Windows
 reactivation
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
https://bugs.launchpad.net/bugs/1318474

Title:
  QEMU update causes Windows reactivation

Status in QEMU:
  Expired

Bug description:
  After updating QEMU the guest OS's detect new hardware. As a result
  any Windows OS sees it as a significant change in hardware and require
  a reactivation.

  Host OS: Ubuntu 14.04 64-bit

  Guest OS's:
  Windows Server 2003 R2 Enterprise
  Windows Server 2008 R2 Enterprise
  Windows Server 2008 R2 Web
  Windows Server 2008 R2 Data Center

  QEMU version: 2.0.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1318474/+subscriptions
