Received: from eggs.gnu.org ([2001:4830:134:3::10]:47482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWf49-0006Ct-1N
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWf45-0003lp-3E
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:49113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWf44-0003lV-TB
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWf43-0005nI-HA
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:05:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 792B42E81C5
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:05:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2017 07:55:24 -0000
From: Thomas Huth <1261320@bugs.launchpad.net>
Reply-To: Bug 1261320 <1261320@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131216093735.6862.14254.malonedeb@soybean.canonical.com>
Message-Id: <20170126075526.11450.94361.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1261320] Re: Virtual Disk with over 16TB
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
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1261320

Title:
  Virtual Disk with over 16TB

Status in QEMU:
  Won't Fix

Bug description:
  Hi,

  is there a option to create a disk for a vm with a size over 16TB.

  the problem that after the diskfile reach 16TB, the disk get a state of r=
ead-only at this limit.
  I know, that 16TB file size is max, is there a option to create the disk =
in mutliple files?
  we want to use 22 TB. in the VM =


  To attach a partition directly to the vm, is not what we want to do.

  best regards

  Chris

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1261320/+subscriptions
