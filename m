Received: from eggs.gnu.org ([209.51.188.92]:34353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCzRE-0001DH-4a
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCzRD-0007uH-0S
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCzRC-0007u3-O0
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCzRB-0007mr-Ra
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 04:29:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CFD3D2E8076
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 04:29:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Apr 2019 04:17:21 -0000
From: Launchpad Bug Tracker <1546680@bugs.launchpad.net>
Reply-To: Bug 1546680 <1546680@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160217182116.22366.12898.malonedeb@soybean.canonical.com>
Message-Id: <155461064161.28623.6635873825513006389.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1546680] Re: Incorrect display colors when
 running big endian guest on POWER8 little endian host
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
https://bugs.launchpad.net/bugs/1546680

Title:
  Incorrect display colors when running big endian guest on POWER8
  little endian host

Status in QEMU:
  Expired

Bug description:
  When running a big endian CentOS guest on a little endian host system
  the display shows severe color issues, probably due to endianness not
  being properly detected / switched in the emulated display hardware.
  Little endian guests show no display issues on the same host hardware
  and software.

  See attachment for an example of the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1546680/+subscriptions
