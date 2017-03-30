Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaXf-0002qM-Cq
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaXe-0000d5-8X
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:45418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctaXe-0000cf-2X
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:55:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctaXd-0000p1-71
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:55:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 33BCB2E80AF
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:55:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 13:39:58 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1569491 <1569491@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160412175749.2128.24352.malonedeb@wampee.canonical.com>
Message-Id: <20170330133959.26414.71832.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1569491] Re: qemu system i386 poor performance on
 e5500 core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Opinion

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1569491

Title:
  qemu system i386 poor performance on e5500 core

Status in QEMU:
  Opinion

Bug description:
  I had been tested with generic core net building or with mtune e5500 but =
i have the same result: performances =

  are extremly low compared with other classes of powerpc cpu.
  The strange is the 5020 2ghz in all emulators been tested by me is compar=
able with a 970MP 2.7 ghz in speed and benchmarks but im facing the half of=
 performance in i386-soft-mmu compared with a 2.5 ghz 970MP.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1569491/+subscriptions
