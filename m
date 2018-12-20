Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga3GF-0006eY-OW
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ga3GE-0003Zr-5C
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:35416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ga3GD-0002Zd-Rt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ga3FW-0003FP-6F
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 18:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2C5E92E8048
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 18:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Dec 2018 18:30:47 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1737883@bugs.launchpad.net>
Reply-To: Bug 1737883 <1737883@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151314764536.10749.10688753671340892012.malonedeb@wampee.canonical.com>
Message-Id: <154533064870.5270.10622712486092739968.launchpad@wampee.canonical.com>
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

** Tags removed: qemu
** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737883

Title:
  Cannot boot FreeBSD on versatilepb machine

Status in QEMU:
  Incomplete

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
