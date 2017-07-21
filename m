Received: from eggs.gnu.org ([2001:4830:134:3::10]:37253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYTag-0000nX-3B
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYTab-0004ed-84
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:47:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:58350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYTab-0004dx-2X
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:47:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYTaa-0005UN-5J
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:47:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 267572E800F
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:47:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 08:30:28 -0000
From: Thomas Huth <1185395@bugs.launchpad.net>
Reply-To: Bug 1185395 <1185395@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130529115415.23233.51064.malonedeb@wampee.canonical.com>
Message-Id: <150062582903.24932.5829137448479837399.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1185395] Re: qemu-1.5.0 savevm error -95 while
 writing vm with ceph-rbd as storage-backend
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
       Status: Incomplete =3D> Triaged

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1185395

Title:
  qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as storage-
  backend

Status in QEMU:
  Triaged

Bug description:
  With a running VM I encounter this strange behaviour, former qemu-version=
s don't show up such an error.
  Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination with=
 ceph-0.56.6?

  ( -95 might be a general "Operation not supported" error? )

  Up to 1.4.2 everything is OK with savevm, though.

  Any help welcome,

  Oliver.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1185395/+subscriptions
