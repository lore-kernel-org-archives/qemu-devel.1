Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dC9zo-0003tH-Nd
	for qemu-devel@nongnu.org; Sat, 20 May 2017 15:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dC9zl-0007Kk-Jl
	for qemu-devel@nongnu.org; Sat, 20 May 2017 15:25:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:52051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dC9zl-0007Kc-DR
	for qemu-devel@nongnu.org; Sat, 20 May 2017 15:24:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dC9zj-0006gd-H7
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 19:24:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3DCB62E804A
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 19:24:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 May 2017 19:08:20 -0000
From: Thomas Huth <1303926@bugs.launchpad.net>
Reply-To: Bug 1303926 <1303926@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140407174130.26245.87358.malonedeb@soybean.canonical.com>
Message-Id: <149530730015.12426.12269479415971082382.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1303926] Re: qemu-system-x86_64 crashed with
 SIGABRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OK, since there hasn't been a reply within 6 months, I assume this is
now fixed. So closing this ticket now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1303926

Title:
  qemu-system-x86_64 crashed with SIGABRT

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  I've been getting this periodically since my upgrade to qemu 2.0 in
  trusty this morning.

  ProblemType: Crash
  DistroRelease: Ubuntu 14.04
  Package: qemu-system-x86 2.0.0~rc1+dfsg-0ubuntu1
  ProcVersionSignature: Ubuntu 3.13.0-23.45-generic 3.13.8
  Uname: Linux 3.13.0-23-generic x86_64
  ApportVersion: 2.14.1-0ubuntu1
  Architecture: amd64
  Date: Mon Apr  7 13:31:53 2014
  ExecutablePath: /usr/bin/qemu-system-x86_64
  InstallationDate: Installed on 2013-11-26 (131 days ago)
  InstallationMedia: Ubuntu 13.10 "Saucy Salamander" - Release amd64 (20131=
016.1)
  ProcEnviron: PATH=3D(custom, no user)
  Registers: No symbol table is loaded.  Use the "file" command.
  Signal: 6
  SourcePackage: qemu
  StacktraceTop:
   =

  Title: qemu-system-x86_64 crashed with SIGABRT
  UpgradeStatus: Upgraded to trusty on 2014-01-17 (79 days ago)
  UserGroups:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1303926/+subscriptions
