Received: from eggs.gnu.org ([2001:4830:134:3::10]:51984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZFIb-0007mj-Vi
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cZFIX-0008Qq-2J
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:11:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:49537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cZFIW-0008QM-Sb
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:11:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cZFIV-0007UT-4z
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 11:11:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 247F32E80C9
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 11:11:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Feb 2017 10:58:20 -0000
From: Thomas Huth <1656710@bugs.launchpad.net>
Reply-To: Bug 1656710 <1656710@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170115231359.21186.42325.malonedeb@gac.canonical.com>
Message-Id: <20170202105820.11557.17602.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1656710] Re: Please support Ctrl-Alt-= to zoom in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D66f6b82bf26cc15e33

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656710

Title:
  Please support Ctrl-Alt-=3D to zoom in

Status in QEMU:
  Fix Committed

Bug description:
  With the GTK3 interface, qemu-system supports pressing Ctrl-Alt-plus
  to zoom in and Ctrl-Alt-minus to zoom out.  However, unlike many
  programs that support similar zoom hotkeys, qemu-system actually
  requires using '+', making the hotkey Ctrl-Alt-Shift-=3D .  Most programs
  with similar zoom hotkeys allow Ctrl-Alt-=3D as a synonym.

  Please consider accepting Ctrl-Alt-=3D as an additional zoom-in hotkey.

  (Observed in QEMU 2.8)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656710/+subscriptions
