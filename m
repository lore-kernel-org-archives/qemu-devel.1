Received: from eggs.gnu.org ([2001:4830:134:3::10]:57010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Yco-00065j-AX
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Ycl-0001cb-6S
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:41:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:35725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d2Ycl-0001cF-0G
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:41:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d2Ych-00059l-Jr
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:41:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 78C512E818D
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:41:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Apr 2017 07:34:48 -0000
From: Thomas Huth <1656710@bugs.launchpad.net>
Reply-To: Bug 1656710 <1656710@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170115231359.21186.42325.malonedeb@gac.canonical.com>
Message-Id: <20170424073449.19931.56731.launchpad@soybean.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656710

Title:
  Please support Ctrl-Alt-=3D to zoom in

Status in QEMU:
  Fix Released

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
