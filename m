Received: from eggs.gnu.org ([2001:4830:134:3::10]:45558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dj33j-0001E8-0E
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 08:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dj33f-0000cG-RT
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 08:40:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:56975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dj33f-0000c0-LD
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 08:40:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dj33d-0004MT-0E
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 12:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1C572E80C7
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 12:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Aug 2017 12:33:12 -0000
From: li <1711828@bugs.launchpad.net>
Reply-To: Bug 1711828 <1711828@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150314599227.11619.13522742205316684478.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711828] [NEW] lock mov non generated #UD
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

qemu 2.8.1 debian 9.1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711828

Title:
  lock mov non generated #UD

Status in QEMU:
  New

Bug description:
  qemu 2.8.1 debian 9.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711828/+subscriptions
