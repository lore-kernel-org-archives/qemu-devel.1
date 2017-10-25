Received: from eggs.gnu.org ([2001:4830:134:3::10]:36528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nim-000486-93
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nii-0006q2-6J
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:58644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7Nii-0006nz-0H
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Nig-0004px-B4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:35:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DCFF02E8082
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:35:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:21:29 -0000
From: Thomas Huth <1376533@bugs.launchpad.net>
Reply-To: Bug 1376533 <1376533@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141002011441.18210.5758.malonedeb@chaenomeles.canonical.com>
Message-Id: <150894488932.17349.11185013113137633675.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1376533] Re: Copyright year should be updated in
 vl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This has been fixed a while ago already, so setting the status to "Fix
released" now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1376533

Title:
  Copyright year should be updated in vl.c

Status in QEMU:
  Fix Released

Bug description:
  When specifying '--version', qemu prints the version along with
  'Copyright (c) 2003-2008'.

  Some users may think that it hasn't been updated since 2008, so the
  end year in version() in vl.c should probably be updated around the
  start of each new year.

  Found in the qemu-2.1.2 source tarball.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1376533/+subscriptions
