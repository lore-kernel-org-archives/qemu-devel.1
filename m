Received: from eggs.gnu.org ([209.51.188.92]:50793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gsKIr-0007mz-Qr
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gsKIp-0003kT-Pe
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:31:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:50784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gsKIn-0003f0-UX
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:31:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gsKIZ-0007fn-9n
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 04:31:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C73132E81B9
	for <qemu-devel@nongnu.org>; Sat,  9 Feb 2019 04:31:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Feb 2019 04:17:42 -0000
From: Launchpad Bug Tracker <1743441@bugs.launchpad.net>
Reply-To: Bug 1743441 <1743441@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151604323239.5020.7297818634644485125.malonedeb@wampee.canonical.com>
Message-Id: <154968586228.19643.8176674184448214506.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743441] Re: OS/2 Warp 4.52 OS2LVM failure
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
https://bugs.launchpad.net/bugs/1743441

Title:
  OS/2 Warp 4.52 OS2LVM failure

Status in QEMU:
  Expired

Bug description:
  When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, e=
tc. I always get an exception in OS2LVM (TRAP 000E). Tried both FAT and HPF=
S. You can reproduce the bug using this disk image: https://drive.google.co=
m/open?id=3D1zzjs9hTS0TK-Xb5hnon8SQ-2C1EmlYfy
  P.S. OS/2 Warp 4.0 boots OK (if installed on FAT, not HPFS)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743441/+subscriptions
