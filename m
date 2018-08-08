Received: from eggs.gnu.org ([2001:4830:134:3::10]:44720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnG8T-0000N5-M0
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnG8Q-0004jJ-Md
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:31:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:58338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fnG8Q-0004ix-Gn
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:31:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fnG8P-0007M6-5Z
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 04:31:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1FBD42E80D4
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 04:31:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Aug 2018 04:17:26 -0000
From: Launchpad Bug Tracker <1463172@bugs.launchpad.net>
Reply-To: Bug 1463172 <1463172@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150608204231.21794.24190.malonedeb@chaenomeles.canonical.com>
Message-Id: <153370184684.9868.10759669714430356838.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1463172] Re: destination arm board hangs after
 migration from x86 source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1463172

Title:
  destination arm board hangs after migration from x86 source

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

Bug description:
  The qemu destination on an arm board hangs after migration from a x86
  source. With qemu emulating Arch, the migration works fine while the
  vm is still in the boot selection screen, but if the machine is
  booted, then the destination arm board vm hangs indefinitely after
  migrating from the x86 source. This bug does not occur the other way
  around, meaning a booted vm originally run on arm board will continue
  to work after migrating to a x86 destination.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1463172/+subscriptions
