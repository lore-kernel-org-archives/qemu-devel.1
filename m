Received: from eggs.gnu.org ([2001:4830:134:3::10]:35748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxEEL-0002C7-27
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxEEF-0002Zv-HV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:26:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:59722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxEEF-0002ZK-C7
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:26:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxEEC-000280-Mi
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:26:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 362C12E84A7
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:26:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 15:06:21 -0000
From: Thomas Huth <1363467@bugs.launchpad.net>
Reply-To: Bug 1363467 <1363467@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140830174124.11818.88240.malonedeb@chaenomeles.canonical.com>
Message-Id: <150652478194.22547.8925310444744686447.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1363467] Re: qemu-system-i386 does not work
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
https://bugs.launchpad.net/bugs/1363467

Title:
  qemu-system-i386 does not work

Status in QEMU:
  Incomplete

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
