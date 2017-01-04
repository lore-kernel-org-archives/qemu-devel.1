Received: from eggs.gnu.org ([2001:4830:134:3::10]:33725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S4-6p
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDu-0004rB-5w
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDt-0004qt-WB
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDs-0002Rz-8m
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2D2B52E818B
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:55 -0000
From: Launchpad Bug Tracker <1317603@bugs.launchpad.net>
Reply-To: Bug 1317603 <1317603@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140508172525.21754.50051.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170104041755.27545.15441.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1317603] Re: qemu-system-ppc does not terminate
 on VM exit
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
https://bugs.launchpad.net/bugs/1317603

Title:
  qemu-system-ppc does not terminate on VM exit

Status in QEMU:
  Won't Fix
Status in qemu package in Ubuntu:
  Expired

Bug description:
  When a VM is created for a p4080-e500mc  ; the VM can not be  rebooted
  or terminated.

  The qemu-system-ppc process must be killed.

  ProblemType: Bug
  DistroRelease: Ubuntu 14.04
  Package: qemu-system-ppc 2.0.0~rc1+dfsg-0ubuntu3.1
  ProcVersionSignature: Ubuntu 3.13.0-24.46-powerpc-e500mc 3.13.9
  Uname: Linux 3.13.9+ ppc
  ApportVersion: 2.14.1-0ubuntu3
  Architecture: powerpc
  Date: Thu May  8 12:20:57 2014
  ProcEnviron:
   TERM=3Dxterm
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: qemu
  UpgradeStatus: Upgraded to trusty on 2014-04-29 (9 days ago)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1317603/+subscriptions
