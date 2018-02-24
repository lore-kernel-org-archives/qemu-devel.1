Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epURy-0007Rc-CT
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 02:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epURv-0001lS-9p
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 02:40:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1epURv-0001kn-3S
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 02:40:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1epURu-0006Tf-0F
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 07:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF54F2E80C3
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 07:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Feb 2018 07:33:11 -0000
From: yabi <1751422@bugs.launchpad.net>
Reply-To: Bug 1751422 <1751422@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151945759115.32735.10228929932246006018.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751422] [NEW] some instructions translate error
 in x86
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

There is some instructions translation error on target i386 in many version=
s, such as 2.11.1, 2.10.2, 2.7.1 and so on.
The error translation instructions include les, lds. I has got a patch, but=
 I have no idea how to apply it.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751422

Title:
  some instructions translate error in x86

Status in QEMU:
  New

Bug description:
  There is some instructions translation error on target i386 in many versi=
ons, such as 2.11.1, 2.10.2, 2.7.1 and so on.
  The error translation instructions include les, lds. I has got a patch, b=
ut I have no idea how to apply it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751422/+subscriptions
