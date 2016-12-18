Received: from eggs.gnu.org ([2001:4830:134:3::10]:37868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cIT6p-0003hA-4T
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 23:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cIT6l-0007dR-S2
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 23:30:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:45782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cIT6l-0007cX-MS
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 23:29:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cIT6j-0002LV-JN
	for <qemu-devel@nongnu.org>; Sun, 18 Dec 2016 04:29:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3BCF62E81C5
	for <qemu-devel@nongnu.org>; Sun, 18 Dec 2016 04:29:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Dec 2016 04:17:40 -0000
From: Launchpad Bug Tracker <786440@bugs.launchpad.net>
Reply-To: Bug 786440 <786440@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110522075851.3340.21746.malonedeb@soybean.canonical.com>
Message-Id: <20161218041740.2928.13180.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 786440] Re: qcow2 double free
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
https://bugs.launchpad.net/bugs/786440

Title:
  qcow2 double free

Status in QEMU:
  Expired

Bug description:
  version 0.14.1 when using qcow2 images, after some time, glibc detects
  a double free or corruption.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/786440/+subscriptions
