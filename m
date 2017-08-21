Received: from eggs.gnu.org ([2001:4830:134:3::10]:49996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djhdU-0001xA-E3
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1djhdQ-00045N-78
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:52269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1djhdQ-00045C-0m
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:00:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1djhdN-0000v3-Mx
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACC5E2E80C3
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Aug 2017 07:43:51 -0000
From: Thomas Huth <1054558@bugs.launchpad.net>
Reply-To: Bug 1054558 <1054558@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120922120346.32541.66809.malonedeb@wampee.canonical.com>
Message-Id: <150330143254.11306.15197667182229117320.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1054558] Re: 1366x768 resolution missing
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
https://bugs.launchpad.net/bugs/1054558

Title:
  1366x768 resolution missing

Status in QEMU:
  New
Status in Debian:
  Confirmed

Bug description:
  I use ArchLinux with QEMU 1.2.0.
  I found that 1366x768 resolution is missing, even if I use -vga std or -v=
ga vmware.
  I think that it is necessary to patch it into the source.
  Also, why not add a command-line option to specify custom resolutions wit=
hout patching the source? (I know that VirtualBox has a hidden option to ad=
d any resolution.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1054558/+subscriptions
