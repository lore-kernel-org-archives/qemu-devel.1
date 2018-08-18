Received: from eggs.gnu.org ([2001:4830:134:3::10]:49459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fqso2-0003rG-1r
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 00:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fqsny-00017d-Uz
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 00:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:36984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fqsny-00016l-Pr
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 00:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fqsnx-0002Z3-4X
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 04:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 042A32E850C
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 04:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Aug 2018 04:17:17 -0000
From: Launchpad Bug Tracker <1777293@bugs.launchpad.net>
Reply-To: Bug 1777293 <1777293@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152919926666.1690.14324498740395706513.malonedeb@chaenomeles.canonical.com>
Message-Id: <153456583873.16620.12042628088922157827.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777293] Re: [REQUEST] SHARING MEMORY WITH HOST
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
https://bugs.launchpad.net/bugs/1777293

Title:
  [REQUEST] SHARING MEMORY WITH HOST

Status in QEMU:
  Expired

Bug description:
  Instead of a preallocated memory heap I would like for QEMU to share
  memory using shm.

  Example: Instead of using 16gb out of 32gb of ram to run Windows 10,
  there would be no option to allocate it, but to share the hosts
  resources; ie giving the host full access to the entire ram stack

  =

  I'm not a great programmer but I'm pretty sure QEMU's team could find thi=
s useful

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777293/+subscriptions
