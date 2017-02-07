Received: from eggs.gnu.org ([2001:4830:134:3::10]:36364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb4ld-0008Lh-Lf
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb4lZ-0005RF-NG
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:21:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:42845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cb4lZ-0005Qt-Gz
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:21:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cb4lW-0002Xv-GL
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 12:20:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C87DE2E80DB
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 12:20:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 12:13:19 -0000
From: Thomas Huth <1662468@bugs.launchpad.net>
Reply-To: Bug 1662468 <1662468@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170207121320.29592.5134.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1662468] Re: [feature request] qemu-img convert
 should respond to control-T like dd
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
https://bugs.launchpad.net/bugs/1662468

Title:
  [feature request] qemu-img convert should respond to control-T like dd

Status in QEMU:
  New

Bug description:
  Since qemu-img convert is a long-running operation, it would be nice
  if it reported progress in response to control-T (SIGINFO) to show
  progress information, much like dd, fsck, dump, cp, etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1662468/+subscriptions
