Received: from eggs.gnu.org ([2001:4830:134:3::10]:39626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7NtA-0001B6-8l
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nt7-0005o4-Jp
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:35092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7Nt7-0005mT-D2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Nt6-0000zz-5m
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:46:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2ABBF2E806E
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:46:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:28:11 -0000
From: Thomas Huth <1361618@bugs.launchpad.net>
Reply-To: Bug 1361618 <1361618@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140826114417.27583.20809.malonedeb@soybean.canonical.com>
Message-Id: <150894529167.17063.14407525850223365085.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1361618] Re: sparc cg3 1152x900 display abnormal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Setting this to "invalid" since it's apparently rather a firmware than a
QEMU issue.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1361618

Title:
  sparc cg3 1152x900 display abnormal

Status in QEMU:
  Invalid

Bug description:
  when I use -vga cg3 -g 1152x900 with qemu-system-sparc, the display is ab=
normal
  I had try qemu-2.1.0 on win2003 with openBIOS or OBP
      qemu-system-sparc.exe -vga cg3 -g 1152x900
  or
      qemu-system-sparc.exe -vga cg3 -g 1152x900 -bios ss5.bin

  I also try qemu-2.0.2 on debian 6.0.1a i686 on VirtualBox host win2003
  with same command, in vnc view, the display is same as on win2003.

  If I don't use -g 1152x900 parameter, everything is OK, sunOS 4.1.4
  work well.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1361618/+subscriptions
