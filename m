Received: from eggs.gnu.org ([2001:4830:134:3::10]:51652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceqGq-0004Oj-ST
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ceqGn-0007Vf-PW
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:40:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:52941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ceqGn-0007Va-Gf
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ceqGl-0008Mk-Dp
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 21:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 52A752E80C2
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 21:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Feb 2017 21:35:27 -0000
From: Phil Troy <phil@philtroy.com>
Reply-To: Bug 1665789 <1665789@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170217213527.4184.5367.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1665789] [NEW] More resolutions for vga displays
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

Would it be possible to add more resolutions for vga displays (which I
am accessing via vnc instead of spice)?  In particular:

- 1080 wide x 1920 high (rotate 1920 x 1080 screen)

- 1920 wide x 1080 + 1980 high (1920 x 1080 screen on top of 1600 x 900
screen)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1665789

Title:
  More resolutions for vga displays

Status in QEMU:
  New

Bug description:
  Would it be possible to add more resolutions for vga displays (which I
  am accessing via vnc instead of spice)?  In particular:

  - 1080 wide x 1920 high (rotate 1920 x 1080 screen)

  - 1920 wide x 1080 + 1980 high (1920 x 1080 screen on top of 1600 x
  900 screen)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1665789/+subscriptions
