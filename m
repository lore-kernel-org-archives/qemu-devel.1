Received: from eggs.gnu.org ([2001:4830:134:3::10]:43649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhwZI-0006YE-3C
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhwZE-0006yT-4z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:37:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhwZD-0006xd-UV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:37:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhwZC-0000KZ-6j
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:37:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1006C2E8086
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:37:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jul 2018 12:25:16 -0000
From: Thomas Huth <1479632@bugs.launchpad.net>
Reply-To: Bug 1479632 <1479632@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150730051710.28657.40581.malonedeb@wampee.canonical.com>
Message-Id: <153243511672.11963.3095021229603422153.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1479632] Re: dos crashing no sound
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1479632

Title:
  dos crashing no sound

Status in QEMU:
  Won't Fix

Bug description:
  I use this command  when I use sound in a program there is no sound and s=
ometimes the program crashes or hangs with no mouse =

  working. I can though reset with the system with  the control menu, but t=
his is further hard to use, because there is no option to scroll through al=
l the commands, I did not visited a wiki page yet.

  This is my command.

  qemu-system-i386  -soundhw all -m 1g -boot menu=3Don -hda dos622_1.img
  -boot d

  I have quite freed up some memory, but that didn't help.

  I used qemu because of a bug in dosbox, but that appeared to be the
  unclutter program and  I have now uninstalled it.

  Not to mention that I did not knew that qemu is in such a beta phase.

  Regards,

  BCJ2014

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1479632/+subscriptions
