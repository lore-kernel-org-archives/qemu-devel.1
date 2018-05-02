Received: from eggs.gnu.org ([2001:4830:134:3::10]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fDjL5-0003gx-9c
	for qemu-devel@nongnu.org; Wed, 02 May 2018 00:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fDjL2-0007TW-6Z
	for qemu-devel@nongnu.org; Wed, 02 May 2018 00:25:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:45812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fDjL2-0007RZ-0G
	for qemu-devel@nongnu.org; Wed, 02 May 2018 00:25:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fDjKv-0001yi-PI
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 04:25:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6B14D2E80EC
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 04:25:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 May 2018 04:17:19 -0000
From: Launchpad Bug Tracker <1751422@bugs.launchpad.net>
Reply-To: Bug 1751422 <1751422@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151945759115.32735.10228929932246006018.malonedeb@chaenomeles.canonical.com>
Message-Id: <152523464107.21776.9310116090588358413.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751422] Re: some instructions translate error in
 x86
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
https://bugs.launchpad.net/bugs/1751422

Title:
  some instructions translate error in x86

Status in QEMU:
  Expired

Bug description:
  There is some instructions translation error on target i386 in many versi=
ons, such as 2.11.1, 2.10.2, 2.7.1 and so on.
  The error translation instructions include les, lds. I has got a patch, b=
ut I have no idea how to apply it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751422/+subscriptions
