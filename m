Received: from eggs.gnu.org ([2001:4830:134:3::10]:55153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3e3C-0001Ht-Fy
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3e39-0000tD-Dh
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:45:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:57122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3e39-0000r9-7g
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:45:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3e37-0001T8-GT
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 08:45:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C5FC2E80CE
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 08:45:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 08:33:27 -0000
From: Thomas Huth <1761027@bugs.launchpad.net>
Reply-To: Bug 1761027 <1761027@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152280226155.9459.1066946337801120026.malonedeb@soybean.canonical.com>
Message-Id: <152283080715.30312.9615209522398880736.malone@gac.canonical.com>
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

Which version of QEMU are you using? And which parameters are you using
when you  start it?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1761027

Title:
  Unexpected error

Status in QEMU:
  Incomplete

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
