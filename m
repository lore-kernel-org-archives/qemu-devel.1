Received: from eggs.gnu.org ([2001:4830:134:3::10]:54987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3WYU-0005iZ-T1
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 20:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3WYQ-0006gg-0d
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 20:45:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:34924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3WYP-0006gY-L1
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 20:45:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3WYO-0004lF-KB
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 00:45:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 951AA2E80C9
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 00:45:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 00:37:41 -0000
From: Mahdi Golestaneh <1761027@bugs.launchpad.net>
Reply-To: Bug 1761027 <1761027@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152280226155.9459.1066946337801120026.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761027] [NEW] Unexpected error
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

When run it this error happens:
Unexpected error in aio_context_set_poll_params() at /home/stefan/src/qemu/=
repo.or.cz/qemu/ar7/util/aio-win32.c:413:
C:\Program Files\qemu\qemu-system-x86_64.exe: AioContext polling is not imp=
lemented on Windows

This application has requested the Runtime to terminate it in an unusual wa=
y.
Please contact the application's support team for more information.


System:
Windows 10 x64

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1761027

Title:
  Unexpected error

Status in QEMU:
  New

Bug description:
  When run it this error happens:
  Unexpected error in aio_context_set_poll_params() at /home/stefan/src/qem=
u/repo.or.cz/qemu/ar7/util/aio-win32.c:413:
  C:\Program Files\qemu\qemu-system-x86_64.exe: AioContext polling is not i=
mplemented on Windows

  This application has requested the Runtime to terminate it in an unusual =
way.
  Please contact the application's support team for more information.


  System:
  Windows 10 x64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1761027/+subscriptions
