Received: from eggs.gnu.org ([2001:4830:134:3::10]:47320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cidvV-0007FQ-Lp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cidvR-0005ME-NH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:18:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:42350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cidvR-0005Lw-IJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:18:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cidvQ-0007K6-F7
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:18:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54F6A2E80C6
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:18:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Feb 2017 09:01:31 -0000
From: Thomas Huth <1214884@bugs.launchpad.net>
Reply-To: Bug 1214884 <1214884@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130821131318.3260.99939.malonedeb@gac.canonical.com>
Message-Id: <20170228090133.7440.66097.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1214884] Re: Support VDI (Virtualbox) snapshots
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1214884

Title:
  Support VDI (Virtualbox) snapshots

Status in QEMU:
  New

Bug description:
  Please support Snapshots in VDI images.

  It seems that VirtualBox uses a snapshot for any changes to the main
  system disc. Even when the user does not create a snapshot.

  So if I want to mount a VDI disc with the recent system changes, I
  have to mount the Snapshot.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1214884/+subscriptions
