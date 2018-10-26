Received: from eggs.gnu.org ([2001:4830:134:3::10]:44233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gG2aQ-0004dq-OT
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gG2aM-00073v-OP
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:55:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:51430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gG2aL-00072q-1i
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:55:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gG2aJ-0006ds-8w
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 13:55:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3BD1F2E804C
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 13:55:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Oct 2018 13:48:01 -0000
From: Valentin Fort <1800156@bugs.launchpad.net>
Reply-To: Bug 1800156 <1800156@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154056168206.13498.14454826046231558494.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1800156] [NEW] windows 8.1 loose grab/leave
 window on windowed
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

Hello, i am new to QEMU and i encounter that annoying issue (windowed)
when i move the mouse a bit too much then it leave the window.

Windows 8.1, Latest QEMU (Windows binaries).

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- windows 8.1 loose grab on windowed
+ windows 8.1 loose grab/leave window on windowed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1800156

Title:
  windows 8.1 loose grab/leave window on windowed

Status in QEMU:
  New

Bug description:
  Hello, i am new to QEMU and i encounter that annoying issue (windowed)
  when i move the mouse a bit too much then it leave the window.

  Windows 8.1, Latest QEMU (Windows binaries).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1800156/+subscriptions
