Received: from eggs.gnu.org ([2001:4830:134:3::10]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eaizy-0004zp-6y
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 09:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eaizt-0002tr-8C
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 09:10:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:41632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eaizt-0002sN-2N
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 09:10:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eaizq-0001rw-Vz
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:10:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 869382E8556
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:10:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jan 2018 14:03:52 -0000
From: MVoloshin <1743214@bugs.launchpad.net>
Reply-To: Bug 1743214 <1743214@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151593225024.11261.9880390596143098449.malonedeb@soybean.canonical.com>
Message-Id: <151593863247.4829.5535571803081056263.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743214] Re: OS/2 Warp 3 support broken in 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I used QEMU 2.11 for Windows from Stephan Weil
(http://qemu.weilnetz.de/). I have Windows 10 (v1709) x64.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743214

Title:
  OS/2 Warp 3 support broken in 2.11

Status in QEMU:
  New

Bug description:
  Hello, I used to run OS/2 Warp 3 on QEMU with the following command line:=
 qemu-system-i386 -vga cirrus -soundhw sb16 -hda os2warp3v2.img -boot c. It=
 runs OK on QEMU 2.10, but immediately gives TRAP 0006 (invalid opcode?) on=
 QEMU 2.11 (see screenshot).
  If it is important I have Fixpack 40 and GRADD installed in OS/2.
  Here is the image:
  https://drive.google.com/open?id=3D15umPecy7JlPLKUP6520MB_87CfrCDWO5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743214/+subscriptions
