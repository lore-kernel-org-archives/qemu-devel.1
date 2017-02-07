Received: from eggs.gnu.org ([2001:4830:134:3::10]:37418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caxPm-0002Jj-9s
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 23:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caxPj-0000YS-8B
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 23:30:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:55036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caxPj-0000Y4-2a
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 23:29:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caxPh-00030c-J6
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 04:29:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 765EF2E80DB
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 04:29:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 04:17:26 -0000
From: Launchpad Bug Tracker <920772@bugs.launchpad.net>
Reply-To: Bug 920772 <920772@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120124014831.2874.7900.malonedeb@wampee.canonical.com>
Message-Id: <20170207041726.8669.48752.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 920772] Re: Win98SE glitches RHEL6.2/CentOS6.2
 QEMU
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
https://bugs.launchpad.net/bugs/920772

Title:
  Win98SE glitches RHEL6.2/CentOS6.2 QEMU

Status in QEMU:
  Expired

Bug description:
  I'm not sure if this is something anyone will be interested in,
  but I ran into some glitches setting up a Windows 98 SE
  QEMU VM with a relatively recent version.  Needed this
  to restore an ancient backup and got it working well
  enough to get the job done.

  Versions
  =3D=3D=3D=3D=3D=3D=3D=3D

  Distro: CentOS 6.2

  Kernel: upstream 3.1.8

  QEMU:
  gpxe-roms-qemu-0.9.7-6.9.el6.noarch
  qemu-img-0.12.1.2-2.209.el6_2.1.x86_64
  qemu-kvm-0.12.1.2-2.209.el6_2.1.x86_64

  Glitches:

  1) Doesn't work in KVM mode, screen goes black
  just after installer is finishing up and switching to
  Win98.  Saw this issue has been around for awhile.

  2) Got it working in QEMU mode, but BIOS plug-n-play
  driver fails.  This prevents other devices from working.

  a) CDROM not recognized

  b) Realtek 8139C driver (installed separately after
  Win98) not recognized.

  I don't need these issues fixed, just reporting the
  in case it's of interest and/or helpful.  Can provide
  more detail on request.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/920772/+subscriptions
