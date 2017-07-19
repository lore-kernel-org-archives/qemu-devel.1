Received: from eggs.gnu.org ([2001:4830:134:3::10]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi9-0005D1-F0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi8-0001p5-HG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXgi8-0001on-A2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXgi7-0003pv-8d
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3C2B32E8076
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 04:17:49 -0000
From: Launchpad Bug Tracker <752476@bugs.launchpad.net>
Reply-To: Bug 752476 <752476@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110406124547.32492.80246.malonedeb@gandwana.canonical.com>
Message-Id: <150043786984.28289.16510117949915677586.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 752476] Re: monitor command mouse_button 1 moves
 mouse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/752476

Title:
  monitor command mouse_button 1 moves mouse

Status in QEMU:
  Expired

Bug description:
  via the qemu -monitor interface, it is possible to move and click the mou=
se using
  mouse_move 20000 10000
  mouse_button 1
  but the mouse_button command always moves the mouse to (0,0) making it ra=
ther unusable to (auto-)trigger any widgets in the VM from the outside.

  Would be nice to have this available for my qemu/kvm based os-autoinst
  testing framework.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/752476/+subscriptions
