Received: from eggs.gnu.org ([2001:4830:134:3::10]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpoyi-000052-Jy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 00:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpoye-0005qt-NS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 00:31:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:47198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpoye-0005p3-I9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 00:31:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpoya-00072W-GF
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:31:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53A3B2E80D1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:31:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Mar 2017 04:17:35 -0000
From: Launchpad Bug Tracker <788886@bugs.launchpad.net>
Reply-To: Bug 788886 <788886@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110526231249.30154.71705.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170320041735.18559.9320.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 788886] Re: Crash with -m32 and gcc-4.2 on Mac OS
 X 64bit
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
https://bugs.launchpad.net/bugs/788886

Title:
  Crash with -m32 and gcc-4.2 on Mac OS X 64bit

Status in QEMU:
  Expired

Bug description:
  For building 32bit Qemu on Mac OS X 10.6.7 , i configure with --extra-
  cflags=3D-m32 --extra-ldflags=3D-m32. make with gcc-4.2 then crashes with:

    GEN   qemu-options.def
    CC    qemu-nbd.o
  gcc-4.2: -E, -S, -save-temps and -M options are not allowed with multiple=
 -arch flags
  make: *** [qemu-nbd.o] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/788886/+subscriptions
