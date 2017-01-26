Received: from eggs.gnu.org ([2001:4830:134:3::10]:43714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWrhE-0001i3-Cm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWrhA-0004N6-FV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:35:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:48952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWrhA-0004Mg-9t
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:35:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWrh8-0006Gm-A2
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 21:35:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CD20A2E80CB
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 21:35:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2017 21:21:35 -0000
From: Thomas Huth <1256548@bugs.launchpad.net>
Reply-To: Bug 1256548 <1256548@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131130185027.7029.31329.malonedeb@soybean.canonical.com>
Message-Id: <20170126212135.8877.31179.malone@gac.canonical.com>
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

Which exact version of QEMU did you use? Does this problem still occur
with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256548

Title:
  qemu windows guest issues

Status in QEMU:
  Incomplete

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
