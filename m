Received: from eggs.gnu.org ([2001:4830:134:3::10]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ebAEN-0005qT-3O
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ebAEJ-0007Ig-Ol
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:15:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:41748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ebAEJ-0007Ht-Db
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:15:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ebAEI-0000fL-9k
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 442F12E854B
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2018 19:07:12 -0000
From: MVoloshin <1743441@bugs.launchpad.net>
Reply-To: Bug 1743441 <1743441@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151604323239.5020.7297818634644485125.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743441] [NEW] OS/2 Warp 4.52 OS2LVM failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, etc=
. I always get an exception in OS2LVM (TRAP 000E). You can reproduce the bu=
g using this disk image: https://drive.google.com/open?id=3D1zzjs9hTS0TK-Xb=
5hnon8SQ-2C1EmlYfy
P.S. OS/2 Warp 4.0 boots OK (if installed on FAT, not HPFS)

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: aurora ecs i386 merlin os2 os2lvm trap warp4

** Attachment added: "os2lvm.PNG"
   https://bugs.launchpad.net/bugs/1743441/+attachment/5037501/+files/os2lv=
m.PNG

** Description changed:

- When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5,
- etc. I always get an exception in OS2LVM (TRAP 000E). You can reproduce
- the bug using this disk image: https://drive.google.com/open?id
- =3D1zzjs9hTS0TK-Xb5hnon8SQ-2C1EmlYfy
+ When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, e=
tc. I always get an exception in OS2LVM (TRAP 000E). You can reproduce the =
bug using this disk image: https://drive.google.com/open?id=3D1zzjs9hTS0TK-=
Xb5hnon8SQ-2C1EmlYfy
+ P.S. OS/2 Warp 4.0 boot OK (if installed on FAT, not HPFS)

** Description changed:

  When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, e=
tc. I always get an exception in OS2LVM (TRAP 000E). You can reproduce the =
bug using this disk image: https://drive.google.com/open?id=3D1zzjs9hTS0TK-=
Xb5hnon8SQ-2C1EmlYfy
- P.S. OS/2 Warp 4.0 boot OK (if installed on FAT, not HPFS)
+ P.S. OS/2 Warp 4.0 boots OK (if installed on FAT, not HPFS)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743441

Title:
  OS/2 Warp 4.52 OS2LVM failure

Status in QEMU:
  New

Bug description:
  When I try to boot OS/2 Warp 4.51 (Merlin), 4.52 (Aurora) or eCS 1.2.5, e=
tc. I always get an exception in OS2LVM (TRAP 000E). You can reproduce the =
bug using this disk image: https://drive.google.com/open?id=3D1zzjs9hTS0TK-=
Xb5hnon8SQ-2C1EmlYfy
  P.S. OS/2 Warp 4.0 boots OK (if installed on FAT, not HPFS)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743441/+subscriptions
