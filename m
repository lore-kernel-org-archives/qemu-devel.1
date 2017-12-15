Received: from eggs.gnu.org ([2001:4830:134:3::10]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsrT-0004Sz-DS
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsrS-0007IP-IU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:23 -0500
Received: from indium.canonical.com ([91.189.90.7]:58292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsrS-0007Gx-CR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:22 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsrR-0006QP-D7
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:29:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 627332E80D1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:29:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:16:53 -0000
From: Thomas Huth <1361912@bugs.launchpad.net>
Reply-To: Bug 1361912 <1361912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140826235443.27649.64438.malonedeb@soybean.canonical.com>
Message-Id: <151335461391.11555.966008636774346291.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1361912] Re: qemu-mips64 Segmentation fault
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1361912

Title:
  qemu-mips64 Segmentation fault

Status in QEMU:
  Fix Released

Bug description:
  When I ran qemu-mips64 for any mips 64 executable , I got this error:

  $ ./qemu-mips64  ../lang
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

  Is this a known issue?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1361912/+subscriptions
