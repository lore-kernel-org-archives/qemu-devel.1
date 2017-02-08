Received: from eggs.gnu.org ([2001:4830:134:3::10]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbOO3-0006L0-Mg
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbOO0-0005ko-Iy
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:18:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:42572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cbOO0-0005kY-Dh
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 04:18:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cbONx-0003ui-Ac
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 09:17:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1CBE62E80C6
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 09:17:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Feb 2017 09:00:51 -0000
From: Thomas Huth <813546@bugs.launchpad.net>
Reply-To: Bug 813546 <813546@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110720142408.18270.82339.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170208090051.5079.65473.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 813546] Re: option to disable PS/2 mouse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, we don't take any patches from the bug tracker... Could you
please post patches on the qemu-devel mailing list instead? Thanks!

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/813546

Title:
  option to disable PS/2 mouse

Status in QEMU:
  New

Bug description:
  Adds an option to disable the PS/2 mouse.

  This is useful to work around bugs in PS/2 drivers in some system or
  testing system without a PS/2 mouse present.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/813546/+subscriptions
