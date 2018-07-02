Received: from eggs.gnu.org ([2001:4830:134:3::10]:39407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZwZh-0005vl-NF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZwZe-0005i6-I6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:00:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:41688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZwZe-0005hr-B5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZwZd-00040c-D3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 11:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E5F12E8005
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 11:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 10:51:32 -0000
From: Bastien Orivel <1779650@bugs.launchpad.net>
Reply-To: Bug 1779650 <1779650@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153052869210.7093.11788523328636614698.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779650] [NEW] The display stays black after
 waking up a domain via SPICE with a QXL card
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

As the title says, in a jessie VM, waking up a VM via the spice remote
view works with a VGA graphic card. With a QXL card though, the domain
wakes up but the display stays black (the keyboard is working though).

Qemu: Master, 281bd281222776229d5dbf84d1a5c6d8d9d2a34b

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779650

Title:
  The display stays black after waking up a domain via SPICE with a QXL
  card

Status in QEMU:
  New

Bug description:
  As the title says, in a jessie VM, waking up a VM via the spice remote
  view works with a VGA graphic card. With a QXL card though, the domain
  wakes up but the display stays black (the keyboard is working though).

  Qemu: Master, 281bd281222776229d5dbf84d1a5c6d8d9d2a34b

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779650/+subscriptions
