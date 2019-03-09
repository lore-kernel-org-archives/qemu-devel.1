Received: from eggs.gnu.org ([209.51.188.92]:39372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2iJ0-0000rI-Eh
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2iIq-0000UR-Mn
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:10:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:42682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2iIq-0000S7-5f
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:10:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2iIo-0007Yn-Vq
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 20:10:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF3BA2E80C3
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 20:10:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Mar 2019 20:02:54 -0000
From: John M <1819289@bugs.launchpad.net>
Reply-To: Bug 1819289 <1819289@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1819289] [NEW] Windows 95 and Windows 98 will not
 install or run
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

The last version of QEMU I have been able to run Windows 95 or Windows
98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
either not install or will not run 95 or 98 at all. I have tried every
combination of options like isapc or no isapc, cpu pentium  or cpu as
486. Tried different memory configurations, but they just don't work
anymore.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819289

Title:
  Windows 95 and Windows 98 will not install or run

Status in QEMU:
  New

Bug description:
  The last version of QEMU I have been able to run Windows 95 or Windows
  98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
  either not install or will not run 95 or 98 at all. I have tried every
  combination of options like isapc or no isapc, cpu pentium  or cpu as
  486. Tried different memory configurations, but they just don't work
  anymore.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions
