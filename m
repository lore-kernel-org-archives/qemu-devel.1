Received: from eggs.gnu.org ([2001:4830:134:3::10]:40487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elaUg-0004vW-Ve
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elaUd-0001qu-Ps
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:19:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:43406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elaUd-0001qZ-Iu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:19:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elaUc-0008N2-I5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 13:19:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7DF3B2E80C3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 13:19:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2018 13:06:17 -0000
From: Thomas Huth <1405176@bugs.launchpad.net>
Reply-To: Bug 1405176 <1405176@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141223133531.22375.47812.malonedeb@gac.canonical.com>
Message-Id: <151852717788.29298.2297719433808699807.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1405176] Re: ctrl+alt+2 not work on gtk display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1405176

Title:
  ctrl+alt+2 not work on gtk display

Status in QEMU:
  Incomplete

Bug description:
  I download 2.2.0 release  on http://wiki.qemu.org/Download
  the monitor console does not appear in gtk display but works for sdl and =
vnc.
  my gtk is 3.12.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1405176/+subscriptions
