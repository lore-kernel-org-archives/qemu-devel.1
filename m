Received: from eggs.gnu.org ([2001:4830:134:3::10]:39051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLR33-0004BH-Ju
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLR2v-0007kT-Ut
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:31:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fLR2v-0007kH-Oz
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:31:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fLR2t-0006ZY-GB
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:31:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 63E9D2E8F4E
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:31:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 May 2018 10:22:16 -0000
From: Thomas Huth <1734810@bugs.launchpad.net>
Reply-To: Bug 1734810 <1734810@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151184788907.20350.3674834740850334109.malonedeb@chaenomeles.canonical.com>
Message-Id: <152707093690.16236.2397661510162219839.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1734810] Re: Windows guest virtual PC running
 abnormally slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If you don't provide the CLI parameters, there's no way we can help
here, sorry. So marking this as "invalid" for the QEMU project.

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1734810

Title:
  Windows guest virtual PC running abnormally slow

Status in Boxes:
  New
Status in KVM:
  New
Status in libvirt:
  New
Status in QEMU:
  Invalid
Status in spice related packages:
  Confirmed
Status in gnome-boxes package in Ubuntu:
  Confirmed

Bug description:
  Guest systems running Windows 10 in a virtualized environment run
  unacceptably slow, with no option in Boxes to offer the virtual
  machine more (or less) cores from my physical CPU.

  ProblemType: Bug
  DistroRelease: Ubuntu 17.10
  Package: gnome-boxes 3.26.1-1
  ProcVersionSignature: Ubuntu 4.13.0-17.20-lowlatency 4.13.8
  Uname: Linux 4.13.0-17-lowlatency x86_64
  ApportVersion: 2.20.7-0ubuntu3.5
  Architecture: amd64
  CurrentDesktop: ubuntu:GNOME
  Date: Tue Nov 28 00:37:11 2017
  ProcEnviron:
   TERM=3Dxterm-256color
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: gnome-boxes
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/gnome-boxes/+bug/1734810/+subscriptions
