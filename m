Received: from eggs.gnu.org ([2001:4830:134:3::10]:59065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dy0yh-0000MO-44
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dy0yc-0005qF-7O
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:29:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dy0yc-0005q4-0k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:29:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dy0yZ-0004fy-Ca
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:29:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46D052E8081
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:29:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Sep 2017 19:19:58 -0000
From: Thomas Huth <1363467@bugs.launchpad.net>
Reply-To: Bug 1363467 <1363467@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140830174124.11818.88240.malonedeb@chaenomeles.canonical.com>
Message-Id: <150671279845.20884.411917358274956052.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1363467] Re: qemu-system-i386 does not work
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Thanks for checking it again!

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1363467

Title:
  qemu-system-i386 does not work

Status in QEMU:
  Fix Released

Bug description:
  I am using QEMU 2.1.0 on a Slackware 14.1 operating system (with Linux
  3.15.8).

  I run QEMU like this:
  $ qemu-system-i386 slackware-14.1-install-dvd.iso
  I have also tested with the "-enable-kvm" and the "-m 1000" options.

  And QEMU does not work.
  I mean, after 10 minutes, nothing is displayed on the screen, I am not ab=
le to see the Slackware installer.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1363467/+subscriptions
