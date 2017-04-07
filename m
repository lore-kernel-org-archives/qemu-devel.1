Received: from eggs.gnu.org ([2001:4830:134:3::10]:45245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUGd-00071M-K2
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUGZ-00043s-HV
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:49:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:40264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUGZ-00043W-CQ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:49:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUGY-0002Vt-CE
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:49:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B8502E80C3
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:49:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:37:33 -0000
From: Thomas Huth <1022023@bugs.launchpad.net>
Reply-To: Bug 1022023 <1022023@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120707081203.6181.33768.malonedeb@gac.canonical.com>
Message-Id: <20170407133734.1912.66162.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1022023] Re: vga/std lacks few wide screen modes.
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
https://bugs.launchpad.net/bugs/1022023

Title:
  vga/std lacks few wide screen modes.

Status in QEMU:
  New

Bug description:
  hi,
  i have noticed that qemu-1.0.1 doesn't support few widescreen modes on -v=
ga std, e.g. 1680x1050, 1600x1000, 1440x900.
  i have a few laptops with kvm and i would like to work with qemu windows =
guest native full wide screen mode.
  could you please add these modes?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1022023/+subscriptions
