Received: from eggs.gnu.org ([2001:4830:134:3::10]:42696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7O1z-00073I-2u
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7O1w-0002l0-Cu
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:55:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:38504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7O1w-0002je-5C
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:55:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7O1t-0002im-Qo
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:55:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C8CFC2E8076
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:55:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:37:02 -0000
From: Thomas Huth <1371915@bugs.launchpad.net>
Reply-To: Bug 1371915 <1371915@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140920125958.18087.58091.malonedeb@chaenomeles.canonical.com>
Message-Id: <150894582355.17076.14241351426036434663.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1371915] Re: Make Uninstall Rule Requested
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
https://bugs.launchpad.net/bugs/1371915

Title:
  Make Uninstall Rule Requested

Status in QEMU:
  New

Bug description:
  Environment: Ubuntu 14.04 - Qemu 2.1.1
  ------------------
  I've configured qemu with some --prefix, compiled the sources and install=
ed the binaries; now, for some reason, I need to uninstall qemu to configur=
e it with the default prefix, recompile the sources and reinstall the binar=
ies.
  However, there's no rule to uninstall qemu.

  All other packages which I have compiled and installed on my system
  offer the possibility to uninstall it: why not Qemu?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1371915/+subscriptions
