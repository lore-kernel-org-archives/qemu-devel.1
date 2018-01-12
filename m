Received: from eggs.gnu.org ([2001:4830:134:3::10]:53710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ea3YP-0000iO-Ua
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ea3YM-0000sX-Mu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:55:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ea3YM-0000rW-Gf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:55:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ea3YL-0000uM-8J
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 17:55:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3C9CD2E854C
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 17:55:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2018 17:43:03 -0000
From: Thomas Huth <1157368@bugs.launchpad.net>
Reply-To: Bug 1157368 <1157368@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130319191503.10848.67844.malonedeb@wampee.canonical.com>
Message-Id: <151577898344.10677.1428801130009947389.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1157368] Re: Desktop background messed up when
 running Raring in a QEMU-based virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1157368

Title:
  Desktop background messed up when running Raring in a QEMU-based
  virtual machine

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Triaged

Bug description:
  Screenshot attached.

  Problem occurs only when choosing the default cirrus graphics card.
  The other graphics cards do not show this problem but are very
  unstable.

  The screenshot is of the whole desktop with a Virtual Machine Manager
  window containing the desktop of the VM. You see that its actual
  background is messed up and also the background images which you can
  choose when right-clicking the background and choosing "Change Desktop
  Background".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1157368/+subscriptions
