Received: from eggs.gnu.org ([2001:4830:134:3::10]:36454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3epQ-00084e-7l
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3epN-0003Hn-6G
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:35:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:49628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3epM-0003HT-VO
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:35:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3epL-00037D-I9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 09:35:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7844C2E80CE
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 09:35:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 09:22:40 -0000
From: Thomas Huth <1761027@bugs.launchpad.net>
Reply-To: Bug 1761027 <1761027@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152280226155.9459.1066946337801120026.malonedeb@soybean.canonical.com>
Message-Id: <152283376031.30027.10090626401887171404.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761027] Re: Unexpected error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> New

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
