Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceqLR-0008U3-PN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceqLO-0002NL-LZ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:45:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:53342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ceqLO-0002N8-Fr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:45:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ceqLN-0000YM-Ko
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 21:45:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 903412E80C3
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 21:45:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Feb 2017 21:38:05 -0000
From: Phil Troy <phil@philtroy.com>
Reply-To: Bug 1665791 <1665791@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170217213805.30329.89107.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1665791] [NEW] Multiple displays each attached to
 a separate vnc connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Would it be possible to create two displays in qemu (for windows 10)
with each accessible by a separate vnc connection?  I think this already
exists for spice (and I would like it because vnc works better for me
than does spice)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1665791

Title:
  Multiple displays each attached to a separate vnc connection

Status in QEMU:
  New

Bug description:
  Would it be possible to create two displays in qemu (for windows 10)
  with each accessible by a separate vnc connection?  I think this
  already exists for spice (and I would like it because vnc works better
  for me than does spice)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1665791/+subscriptions
