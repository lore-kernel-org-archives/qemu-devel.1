Received: from eggs.gnu.org ([2001:4830:134:3::10]:46061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3S7P-0008R7-V8
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 16:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3S7L-0007XG-3u
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 16:01:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:56440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3S7K-0007WG-TR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 16:01:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3S7J-0006Qe-Fx
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 20:01:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 527B82E80CD
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 20:01:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Apr 2018 19:49:18 -0000
From: Fritz Hudnut <este.el.paz@gmail.com>
Reply-To: Bug 1760176 <1760176@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152243541894.4250.1548453889395485127.malonedeb@chaenomeles.canonical.com>
	<152278174998.30756.8908259323086367658.malone@gac.canonical.com>
Message-Id: <CAG62idCnhZXy6rS20uiSHHk+LDzj-7jYn+qjrZEHGTRV1L8YcQ@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1760176] Re: optical drive doesn't open in
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

@John Snow:

Don't know on the "QEMU" front, this is install to HD partitions of Lu
18.04 . . . while trying to burn an iso to DVD, pressing the "eject"
keyboard button will not open the open drive door, so no DVD can be put
there . . . problem remains in Lu.  Whereas I have a couple installs of
OpenSUSE & OSX and the keyboard "eject" button works without issue . . . .

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1760176

Title:
  optical drive doesn't open in Lubuntu 18.04 on '12 MacPro

Status in QEMU:
  Incomplete

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
