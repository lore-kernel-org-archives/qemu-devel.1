Received: from eggs.gnu.org ([2001:4830:134:3::10]:49359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYFDK-0008Dg-VM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYFDH-0002Vd-Hh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:33158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fYFDH-0002UT-By
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:30:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fYFDG-0001PC-AA
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 18:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 302412E80C3
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 18:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Jun 2018 18:16:44 -0000
From: Bruce Campbell <yakman2020@gmail.com>
Reply-To: Bug 1778966 <1778966@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153012207304.7182.2374266143525192096.malonedeb@soybean.canonical.com>
Message-Id: <153012340437.6910.15220500448546942870.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1778966] Re: Windows 1803 and later crashes on KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  For a bionic host, using the current public kvm modules, KVM is not
- capable of booting a WindowsInsider or msdn Windows 1803 iso. In
- stallign from an ISO from a started windows 2016 guest results in an
- unbootable and unrepairable guest.
+ capable of booting a WindowsInsider or msdn Windows 1803 Windows Server
+ iso. In snstalling from an ISO from a started windows 2016 guest results
+ in an unbootable and unrepairable guest.
  =

  The hardware is a threadripper 1920x with 32GB of main memory, disk
  mydigital BPX SSD and WD based 4 column RAID 5 via mdadm.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778966

Title:
  Windows 1803 and later crashes on KVM

Status in QEMU:
  New

Bug description:
  For a bionic host, using the current public kvm modules, KVM is not
  capable of booting a WindowsInsider or msdn Windows 1803 Windows
  Server iso. In snstalling from an ISO from a started windows 2016
  guest results in an unbootable and unrepairable guest.

  The hardware is a threadripper 1920x with 32GB of main memory, disk
  mydigital BPX SSD and WD based 4 column RAID 5 via mdadm.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778966/+subscriptions
