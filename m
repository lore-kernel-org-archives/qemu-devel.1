Received: from eggs.gnu.org ([2001:4830:134:3::10]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ea9cr-0006Hp-MP
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 19:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ea9co-0007C9-JT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 19:24:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:48242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ea9co-0007AV-D1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 19:24:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ea9cm-0007Mz-56
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 00:24:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 082272E8550
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 00:24:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jan 2018 00:11:42 -0000
From: Till Kamppeter <1157368@bugs.launchpad.net>
Reply-To: Bug 1157368 <1157368@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130319191503.10848.67844.malonedeb@wampee.canonical.com>
Message-Id: <151580230236.10413.15736998991995621412.malone@gac.canonical.com>
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

This did never occur again for me. So this can get closed.

** Changed in: qemu (Ubuntu)
       Status: Triaged =3D> Invalid

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1157368

Title:
  Desktop background messed up when running Raring in a QEMU-based
  virtual machine

Status in QEMU:
  Invalid
Status in qemu package in Ubuntu:
  Invalid

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
