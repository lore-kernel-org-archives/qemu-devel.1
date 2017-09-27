Received: from eggs.gnu.org ([2001:4830:134:3::10]:42819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxBUR-0005Tv-3Q
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxBUN-0007lO-TT
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxBUN-0007kL-OG
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:30:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxBUL-00044O-0H
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 12:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F0C942E804E
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 12:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 12:21:51 -0000
From: R Naveen Kumar <raju.naveenkumar.s@gmail.com>
Reply-To: Bug 1719870 <1719870@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150651491208.6275.5437921155583182268.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719870] [NEW] Converting 100G VHDX fixed image
 to QCOW2 fails
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

Virtual Size recognized incorrectly for VHDX fixed disk and conversion
fails with error Expression: !qiov || bytes =3D=3D qiov->size


PS > & 'C:\Program Files\qemu\qemu-img.exe' --version
qemu-img version 2.10.0 (v2.10.0-11669-g579e69bd5b-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719870

Title:
  Converting 100G VHDX fixed image to QCOW2 fails

Status in QEMU:
  New

Bug description:
  Virtual Size recognized incorrectly for VHDX fixed disk and conversion
  fails with error Expression: !qiov || bytes =3D=3D qiov->size


  PS > & 'C:\Program Files\qemu\qemu-img.exe' --version
  qemu-img version 2.10.0 (v2.10.0-11669-g579e69bd5b-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719870/+subscriptions
