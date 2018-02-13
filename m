Received: from eggs.gnu.org ([2001:4830:134:3::10]:42320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elaZi-00017p-Nk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elaZf-00065B-IB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:24:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:45120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elaZf-00062x-Cd
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:24:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elaZc-0000jQ-Ho
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 13:24:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6EB692E80CD
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 13:24:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2018 13:12:45 -0000
From: Thomas Huth <1392504@bugs.launchpad.net>
Reply-To: Bug 1392504 <1392504@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141113221259.14703.69827.malonedeb@wampee.canonical.com>
Message-Id: <151852756770.29573.15093344179616625994.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1392504] Re: libvirt not relabeling devices on
 USB Passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1392504

Title:
  libvirt not relabeling devices on USB Passthrough

Status in libvirt package in Ubuntu:
  Triaged
Status in qemu package in Ubuntu:
  New

Bug description:
  After upgrading from Ubuntu 14.04 to Ubuntu 14.10 USB passthrough in
  QEMU (version is now 2.1.0 - Debian2.1+dfsg-4ubuntu6.1) is not working
  any more. Already tried to remove and attach the USB devices. I use 1
  USB2 HDD  +  1 USB3 HDD to a virtual linux machine; 1 USB2 HDD to a
  virual FNAS machine and a USB 2camera to virtual Win7 machine. All
  these devices are not working any more.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1392504/+subscriptio=
ns
