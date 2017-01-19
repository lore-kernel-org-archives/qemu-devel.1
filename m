Received: from eggs.gnu.org ([2001:4830:134:3::10]:41195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUGJL-0008DR-HJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUGJI-0002qr-6N
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:15:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:57909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUGJH-0002qV-Uj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:15:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUGJG-0006Qa-TM
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 17:15:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D83A82E80C0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 17:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 17:09:30 -0000
From: therock247uk <therock247uk@247fixes.com>
Reply-To: Bug 1657841 <1657841@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170119170931.14633.66977.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657841] [NEW] QEMU Intel HAX Windows
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

Hi,

Using the latest exe's from http://qemu.weilnetz.de/w32/

C:\Users\therock247uk\Desktop\jan\qemu-w64-setup-20170113>qemu-system-i386 =
--enable-hax -m 512 -cdrom C:\Users\therock247uk\Desktop\jan\en_windows_xp_=
professional_with_service_pack_3_x86_cd_x14-80428.iso
HAX is working and emulator runs in fast virt mode.
Failed to allocate 20000000 memory

The emulator seems to hang/get stuck during booting from the CD taking
out --enable-hax allows it to boot.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657841

Title:
  QEMU Intel HAX Windows

Status in QEMU:
  New

Bug description:
  Hi,

  Using the latest exe's from http://qemu.weilnetz.de/w32/

  C:\Users\therock247uk\Desktop\jan\qemu-w64-setup-20170113>qemu-system-i38=
6 --enable-hax -m 512 -cdrom C:\Users\therock247uk\Desktop\jan\en_windows_x=
p_professional_with_service_pack_3_x86_cd_x14-80428.iso
  HAX is working and emulator runs in fast virt mode.
  Failed to allocate 20000000 memory

  The emulator seems to hang/get stuck during booting from the CD taking
  out --enable-hax allows it to boot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657841/+subscriptions
