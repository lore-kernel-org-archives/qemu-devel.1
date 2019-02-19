Received: from eggs.gnu.org ([209.51.188.92]:50066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gvwzQ-0001qh-Kt
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gvwzL-0004cW-RL
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:26:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:41760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gvwzC-0004TV-9q
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:26:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gvwyi-0005ww-Qr
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:25:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9BAE82E80D4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:25:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Feb 2019 04:18:10 -0000
From: Launchpad Bug Tracker <1737883@bugs.launchpad.net>
Reply-To: Bug 1737883 <1737883@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151314764536.10749.10688753671340892012.malonedeb@wampee.canonical.com>
Message-Id: <155054989070.31536.4613822163706254657.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737883] Re: Cannot boot FreeBSD on versatilepb
 machine
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
https://bugs.launchpad.net/bugs/1737883

Title:
  Cannot boot FreeBSD on versatilepb machine

Status in QEMU:
  Expired

Bug description:
  I know some years ago it was possible to boot FreeBSD in QEMU versatilepb=
 machine
  https://kernelnomicon.org/?p=3D229 (you can download image and kernel usi=
ng web.archive.org)
  Now when I try to do that I get only black screen with no output even in =
QEMU console.
  I also added -global versatile_pci.broken-irq-mapping=3D1, but this seem =
to have no effect.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737883/+subscriptions
