Received: from eggs.gnu.org ([2001:4830:134:3::10]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dz5ny-00045W-G5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dz5nt-00074c-QF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:51:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:53182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dz5nt-00071x-Iu
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:50:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dz5nq-0002Km-FU
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 18:50:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54BA52E80D9
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 18:50:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Oct 2017 18:37:49 -0000
From: Alchemist <xavier.miller@cauwe.org>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <150696946999.1635.5193951495680741881.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] Re: core dump
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

# uname -a && locale-gen =

Linux **** 4.13.4-gentoo #1 SMP PREEMPT Thu Sep 28 09:41:30 CEST 2017 armv7=
l Intel(R) Celeron(R) 2957U @ 1.40GHz GNU/Linux
 * Generating 8 locales (this might take a while) with 2 jobs
 *  (2/8) Generating en_US.UTF-8 ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (1/8) Generating en_US.ISO-8859-1 ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (3/8) Generating fr_BE.ISO-8859-15@euro ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (4/8) Generating fr_BE.ISO-8859-1 ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (5/8) Generating fr_BE.UTF-8 ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (6/8) Generating fr_FR.ISO-8859-15@euro ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (7/8) Generating fr_FR.ISO-8859-1 ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 *  (8/8) Generating fr_FR.UTF-8 ...
localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `e=
c >=3D 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped                     =
                                                                           =
                                                                           =
       [ !! ]
 * Generation complete
 * Adding locales to archive ...
incomplete set of locale files in "//usr/lib/locale/en_US"
incomplete set of locale files in "//usr/lib/locale/en_US.utf8"
incomplete set of locale files in "//usr/lib/locale/fr_BE"
incomplete set of locale files in "//usr/lib/locale/fr_BE@euro"
incomplete set of locale files in "//usr/lib/locale/fr_BE.utf8"
incomplete set of locale files in "//usr/lib/locale/fr_FR"
incomplete set of locale files in "//usr/lib/locale/fr_FR@euro"
incomplete set of locale files in "//usr/lib/locale/fr_FR.utf8"            =
                                                                           =
                                                                           =
       [ !! ]

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673976

Title:
  core dump

Status in QEMU:
  Incomplete

Bug description:
  I'm running a command (locale-gen) inside of an armv7h chroot mounted
  on my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
  chroot file system and I get a core dump.

  locale-gen
  Generating locales...
  =C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:=
360: __spawnix: Assertion `ec >=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  /usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped)=
 localedef -i $input -c -f $charset -A /usr/share/locale/locale.alias $loca=
le

  I've done this same thing successfully for years, but this breakage
  has appeared some time in the last 3 or so months. Possibly with the
  update to qemu version 2.8.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673976/+subscriptions
