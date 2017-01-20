Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdjG-000288-TN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdjB-00052k-Vo
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:16:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:46482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUdjB-00050Z-PX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:15:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUdjA-0001AR-Sh
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:15:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D73542E805E
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:15:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 18:02:35 -0000
From: Thomas Huth <824074@bugs.launchpad.net>
Reply-To: Bug 824074 <824074@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110810165735.14802.47701.malonedeb@soybean.canonical.com>
Message-Id: <20170120180236.21271.35704.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 824074] Re: Provide runtime option to expose the
 supported list of keymaps for vnc
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
https://bugs.launchpad.net/bugs/824074

Title:
  Provide runtime option to expose the supported list of keymaps for vnc

Status in QEMU:
  New

Bug description:
  As discussed in the ganeti group[1], I'm opening this bug to request
  that qemu provides a runtime command or switch to list the supported
  keymaps for vnc.

   [1] -
  http://groups.google.com/group/ganeti/browse_thread/thread/dd524f5311d8d7=
9e

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/824074/+subscriptions
