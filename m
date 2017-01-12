Received: from eggs.gnu.org ([2001:4830:134:3::10]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRbdc-00041y-Lw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 04:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRbdY-0008Ub-F5
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 04:25:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:46434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRbdY-0008UW-9P
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 04:25:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRbdW-0000a9-Ud
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 09:25:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 044402E80E4
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 09:25:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jan 2017 09:07:47 -0000
From: Vic3Dexe <622367@bugs.launchpad.net>
Reply-To: Bug 622367 <622367@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100822180158.18591.82477.malonedeb@palladium.canonical.com>
Message-Id: <20170112090747.12526.29144.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 622367] Re: No BIOS MPFP structure with smp=92
 and more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Man, really? xD
6 years have passed...
Close the ticket please, I don't have this code anymore.
...
still laughing... sorry

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/622367

Title:
  No BIOS MPFP structure with smp=3D92 and more

Status in QEMU:
  Incomplete

Bug description:
  qemu 0.12.2, SeaBios 0.5.1, running qemu-system-x86_64.exe with option -s=
mp.
  If smp>=3D92 then no MP floating point structure present in 1 Mb. This ma=
y be verified by pmemsave 0 0x100000 in debugger and search for _MP_ signat=
ure in file.

  qemu 0.10.5 (bios build 05/08/09) can smp=3D128 (and even 255 if not
  hangs :).

  Host win 7 x64 RTM 7600.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/622367/+subscriptions
