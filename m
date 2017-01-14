Received: from eggs.gnu.org ([2001:4830:134:3::10]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSJiM-0006ka-1N
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSJiI-0001hx-TC
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:29:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:50441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cSJiI-0001hr-Ng
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:29:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cSJiH-0000Ii-79
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 08:29:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0BBE62E80AF
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 08:29:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Jan 2017 08:19:01 -0000
From: Thomas Huth <808737@bugs.launchpad.net>
Reply-To: Bug 808737 <808737@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110711114151.19872.43356.malonedeb@wampee.canonical.com>
Message-Id: <20170114081901.20935.32860.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 808737] Re: No option to load additional binary
 files from command line in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/808737

Title:
  No option to load additional binary files from command line in QEMU

Status in QEMU:
  Fix Released

Bug description:
  There is no command line option like -kerner, or -initrd to load an
  arbitrary binary file to a RAM location when launching QEMU.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/808737/+subscriptions
