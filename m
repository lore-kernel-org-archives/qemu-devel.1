Received: from eggs.gnu.org ([2001:4830:134:3::10]:39149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flfhs-000675-Jl
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 15:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flfhp-0007iu-Gr
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 15:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:50424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1flfhp-0007h1-Ao
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 15:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1flfhn-00022g-6i
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 19:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 13B2D2E80D4
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 19:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Aug 2018 19:19:35 -0000
From: Ra Cohen <1785308@bugs.launchpad.net>
Reply-To: Bug 1785308 <1785308@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153332397534.32176.3210060625384706087.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785308] [NEW] 0x8 exception encountered but not
 handled
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

Present in all QEMU versions.

OS is triple page faulting and crashing rather than handling the
expected double page fault properly. The same OS works in Bochs so I
know its not the problem.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785308

Title:
  0x8 exception encountered but not handled

Status in QEMU:
  New

Bug description:
  Present in all QEMU versions.

  OS is triple page faulting and crashing rather than handling the
  expected double page fault properly. The same OS works in Bochs so I
  know its not the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785308/+subscriptions
