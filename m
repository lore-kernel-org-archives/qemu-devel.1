Received: from eggs.gnu.org ([2001:4830:134:3::10]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJWYA-0006UU-H4
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJWXJ-0008Sw-HE
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gJWXJ-0007dk-41
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 23:30:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gJWWu-0001xf-Aj
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:30:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F9A02E805B
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 04:30:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Nov 2018 04:17:19 -0000
From: Launchpad Bug Tracker <1496384@bugs.launchpad.net>
Reply-To: Bug 1496384 <1496384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150916130241.19267.23402.malonedeb@soybean.canonical.com>
Message-Id: <154139143998.4655.2787568680500582705.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1496384] Re: Error 0x5D in Qemu for Windows
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
https://bugs.launchpad.net/bugs/1496384

Title:
  Error 0x5D in Qemu for Windows

Status in QEMU:
  Expired

Bug description:
  The reason to use qemu for Windows is that the mouse in emulated Windows =
works well while it is unusable in  qemu at Ubuntu. =

  Alternative solution/bug is mouse usability in qemu for Linux.
  Well-known issue of error 0x5D when booting Win 7 x64 on qemu without kvm=
, marked as resolved at Linux.

  Used qemu for Windows downloaded from http://qemu.weilnetz.de/
  Tested on  qemu 2.3.94 64-bit and  qemu 2.4.0 32-bit.

  Options :
  qemu-system-x86_64.exe  -m 1536 -cpu qemu64,+nx,+pae,+mce,+cx8,+apic,+sep=
,+mtrr,+pge,+mca,+cmov,+pat,+pse36,+clflush,+acpi,+mmx,+fxsr,+sse,+sse2,+ss=
,+fxsr,+sse,+sse2,+ss,+de,+mtrr,+mca,+clflush
   win_7_work.qcow2

  On qemu at Ubuntu with kvm Win7 x64 works ,but mouse is unusable as
  mentioned above.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1496384/+subscriptions
