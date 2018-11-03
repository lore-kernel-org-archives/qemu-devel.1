Received: from eggs.gnu.org ([2001:4830:134:3::10]:55609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gInaA-0007OS-VP
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 00:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gIna6-000280-TQ
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 00:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:60004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gIna5-00024t-RX
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 00:30:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gIna1-0006j8-TS
	for <qemu-devel@nongnu.org>; Sat, 03 Nov 2018 04:30:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DC1D92E80C9
	for <qemu-devel@nongnu.org>; Sat,  3 Nov 2018 04:30:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Nov 2018 04:17:20 -0000
From: Launchpad Bug Tracker <588693@bugs.launchpad.net>
Reply-To: Bug 588693 <588693@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100602125159.13777.33649.malonedeb@gandwana.canonical.com>
Message-Id: <154121864096.11376.5647503652302876226.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 588693] Re: CD-ROM devices always return a one
 session, one track TOC
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
https://bugs.launchpad.net/bugs/588693

Title:
  CD-ROM devices always return a one session, one track TOC

Status in QEMU:
  Expired

Bug description:
  CD-ROM devices always return a one session, one track TOC, no matter
  if it is using ioctl's with the host or DMG images (both able of
  having multi track, multi session discs).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/588693/+subscriptions
