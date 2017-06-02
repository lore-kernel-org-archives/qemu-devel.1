Received: from eggs.gnu.org ([2001:4830:134:3::10]:55911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGnbO-0002ZU-7A
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dGnbJ-0000Xi-6Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:30:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:51019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dGnbJ-0000XE-0b
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dGnbH-0004vx-Uw
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 14:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA2B02E8194
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jun 2017 14:20:32 -0000
From: Anatol Pomozov <1695286@bugs.launchpad.net>
Reply-To: Bug 1695286 <1695286@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149641323250.2944.14553765614287047216.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1695286] [NEW] Add multiboot2 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

multiboot2 is a recent specification that resolves some of the issues of
multiboot. Multiboot2 is supported by some tools already (e.g. grub).

It would be great if one can run OS with multiboot2 using '-kernel'
option, similar as it is done now with multiboot images.

Quick googling shows there is a Debian bug and patch that adds multiboot
support https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D621529 Would
it be possible to integrate it to QEMU upstream?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1695286

Title:
  Add multiboot2 support

Status in QEMU:
  New

Bug description:
  multiboot2 is a recent specification that resolves some of the issues
  of multiboot. Multiboot2 is supported by some tools already (e.g.
  grub).

  It would be great if one can run OS with multiboot2 using '-kernel'
  option, similar as it is done now with multiboot images.

  Quick googling shows there is a Debian bug and patch that adds
  multiboot support https://bugs.debian.org/cgi-
  bin/bugreport.cgi?bug=3D621529 Would it be possible to integrate it to
  QEMU upstream?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1695286/+subscriptions
