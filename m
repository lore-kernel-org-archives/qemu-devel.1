Received: from eggs.gnu.org ([2001:4830:134:3::10]:52684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1csinU-0003n8-6C
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1csinR-0002eK-3t
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:31:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:34937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1csinQ-0002dQ-UD
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 00:31:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1csinP-0008SY-KP
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:31:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C639A2E8275
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:31:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Mar 2017 04:18:19 -0000
From: Launchpad Bug Tracker <1256548@bugs.launchpad.net>
Reply-To: Bug 1256548 <1256548@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131130185027.7029.31329.malonedeb@soybean.canonical.com>
Message-Id: <20170328041819.17594.3025.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1256548] Re: qemu windows guest issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256548

Title:
  qemu windows guest issues

Status in QEMU:
  Expired

Bug description:
  Ive noticed the following in the latest qemu build on mingw 64bit for
  windows

  older guests like windows 9* no longer boot they mostly just bsod its bee=
n this way for ages same with 32bit builds
  xp 64bit and other 64bit windows guests no longer work and havent for age=
s same with 32bit builds =

  xp 32bit guest doesent work under 64bit builds but they work on 32bit bui=
lds

  are the issues with the coroutine stuff on windows builds being worked
  on? id gladly test patches

  just a few observations is all :)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1256548/+subscriptions
