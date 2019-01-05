Received: from eggsout.gnu.org ([209.51.188.92]:41862 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gfdbZ-0002c2-BT
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 23:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gfdbV-00047p-As
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:50088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gfdbV-00047M-4W
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 23:30:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gfdbU-0003K0-A6
	for <qemu-devel@nongnu.org>; Sat, 05 Jan 2019 04:30:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4489A2E8005
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 04:30:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Jan 2019 04:17:40 -0000
From: Launchpad Bug Tracker <1513234@bugs.launchpad.net>
Reply-To: Bug 1513234 <1513234@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151104215429.31656.76099.malonedeb@wampee.canonical.com>
Message-Id: <154666186043.14887.16705741082824531872.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1513234] Re: Cannot ping guest from host after
 closing laptop lid, and re-opening
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
https://bugs.launchpad.net/bugs/1513234

Title:
  Cannot ping guest from host after closing laptop lid, and re-opening

Status in QEMU:
  Expired

Bug description:
  I am running Ubuntu 15.10 (this issue also exists on 15.04) x64.
  Desktop environment to re-produce is either GNOME 3.16 or OpenBox-3.

  I have a Windows 8.1 VM that I run with QEMU and I will work out of
  that for my job most of the day. When I am going to leave I like to
  just close my laptop lid, come home, and then get back at it.
  Unfortunately whenever I get home and open back up my laptop, I can no
  longer RDP into my VM and can no longer ping it from the host.

  If I open up Virt-Manager I can see the desktop via the Console page
  but cannot RDP into it with FreeRDP (I use FreeRDP all day on this
  machine so I know this works fine).

  If I use the Console tab to login to the Windows VM again, I notice
  that I can ping the host from the guest and am connected to the
  internet. Just can't seem to communicate with the VM via its IP
  anymore.

  I have a NIC NAT virtual card and am using a Bridge

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1513234/+subscriptions
