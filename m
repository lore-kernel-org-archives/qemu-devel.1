Received: from eggs.gnu.org ([2001:4830:134:3::10]:33231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUMgT-0002i9-8C
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 21:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUMgQ-0007jV-4t
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 21:40:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:45970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fUMgP-0007jE-Ty
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 21:40:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fUMgO-000141-O6
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 01:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92F212E80C8
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 01:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Jun 2018 01:34:26 -0000
From: john maser <1777293@bugs.launchpad.net>
Reply-To: Bug 1777293 <1777293@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152919926666.1690.14324498740395706513.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777293] [NEW] [REQUEST[ SHARING MEMORY WITH HOST
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

Instead of a preallocated memory heap I would like for QEMU to share
memory using shm.

Example: Instead of using 16gb out of 32gb of ram to run Windows 10,
there would be no option to allocate it, but to share the hosts
resources; ie giving the host full access to the entire ram stack


I'm not a great programmer but I'm pretty sure QEMU's team could find this =
useful

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777293

Title:
  [REQUEST[ SHARING MEMORY WITH HOST

Status in QEMU:
  New

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
