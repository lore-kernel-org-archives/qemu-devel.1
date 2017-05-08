Received: from eggs.gnu.org ([2001:4830:134:3::10]:34172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7aJ1-0006Pm-H6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7aIy-0000ek-F3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:29:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:50475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d7aIy-0000eM-97
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:29:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d7aIw-0007ND-1S
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:29:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 09CF22E80C2
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 04:29:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 May 2017 04:17:46 -0000
From: Launchpad Bug Tracker <1274170@bugs.launchpad.net>
Reply-To: Bug 1274170 <1274170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140129161114.30551.55586.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170508041746.28191.7567.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1274170] Re: qemu window hides in the background
 on osx
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
https://bugs.launchpad.net/bugs/1274170

Title:
  qemu window hides in the background on osx

Status in QEMU:
  Expired

Bug description:
  When launching qemu on OSX (10.8.5), the window comes up in the
  background.  A bit of googling shows that the addition of [NSApp
  activateIgnoringOtherApps:YES]; before the [NSApp run]; in main fixes
  this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1274170/+subscriptions
