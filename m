Received: from eggs.gnu.org ([2001:4830:134:3::10]:56207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cfk5h-0000KA-6J
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cfk5e-00010w-06
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:17:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:40508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cfk5d-00010U-QO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:17:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cfk5b-00025D-BF
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:16:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 06A6D2E80CB
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:16:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2017 09:03:42 -0000
From: Thomas Huth <741115@bugs.launchpad.net>
Reply-To: Bug 741115 <741115@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110323164949.17887.98157.malonedeb@soybean.canonical.com>
Message-Id: <20170220090342.4151.10984.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 741115] Re: Add support of coprocessor cp15,
 cp14 registers exposion in the embedded gdb server
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
https://bugs.launchpad.net/bugs/741115

Title:
  Add support of coprocessor cp15, cp14 registers exposion in the
  embedded gdb server

Status in QEMU:
  New

Bug description:
  Please add support of exposion of ARM coprocesor registers/logic at the e=
mbedded gdb server,
   for example of cp15, cp14, etc registers.

  Related project http://jtagarmgdbsrvr.sourceforge.net/index.html

  Also filled bug in the GDB
  http://sourceware.org/bugzilla/show_bug.cgi?id=3D12602

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/741115/+subscriptions
