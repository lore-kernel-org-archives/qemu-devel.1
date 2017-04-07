Received: from eggs.gnu.org ([2001:4830:134:3::10]:43741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUCK-0003cd-4D
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUCF-0001ck-3e
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:39290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUCE-0001cC-Tm
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUCD-0008W4-2z
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:45:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8FE6C2E80D8
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:45:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:35:44 -0000
From: Thomas Huth <1020484@bugs.launchpad.net>
Reply-To: Bug 1020484 <1020484@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120703094755.29916.21218.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170407133546.31608.25994.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1020484] Re: RFE: Support spice via unix domain
 socket
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
https://bugs.launchpad.net/bugs/1020484

Title:
  RFE: Support spice via unix domain socket

Status in QEMU:
  New

Bug description:
  According to the man page, spice can be only used via TCP/IP in
  opposite to VNC, which can also be configured to listen on a unix
  domain socket. To make it easy to use spice without exposing the
  interface, please support unix domain sockets as well. I can try  to
  provide a patch, if you can point me to the source code where TCP/IP
  socket is opened.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1020484/+subscriptions
