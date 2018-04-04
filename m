Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3jzH-0002bz-0U
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3jzB-0001eg-SK
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:06:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:49080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3jzB-0001du-L4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:06:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3jzA-0000pD-Gh
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 15:06:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7B9D72E80D1
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 15:06:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 15:00:04 -0000
From: John Snow <1760176@bugs.launchpad.net>
Reply-To: Bug 1760176 <1760176@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152243541894.4250.1548453889395485127.malonedeb@chaenomeles.canonical.com>
Message-Id: <152285400468.9393.7627171635484474679.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1760176] Re: optical drive doesn't open in
 Lubuntu 18.04 on '12 MacPro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You probably meant to file this bug against a different component,
you've filed it against QEMU which is an emulator/hypervisor for VMs.

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1760176

Title:
  optical drive doesn't open in Lubuntu 18.04 on '12 MacPro

Status in QEMU:
  Invalid

Bug description:
  Running an install to HD of Lubuntu 18.04 and after running
  update/upgrade this morning now the optical drive door doesn't respond
  to keyboard "eject" key on a Mac keyboard for '12 MacPro . . . .  I
  tried to use "xfburn" to get the door to open, nothing seems to get it
  to work that I know of.  Yesterday there was no issue . . . .  Tried
  to run "apt -f install" and it showed some old kernels to "autoremove"
  . . . which I did; didn't try to reboot into old kernel to test,
  perhaps now old kernel is gone?

  F

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1760176/+subscriptions
