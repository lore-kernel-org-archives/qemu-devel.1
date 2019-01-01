Received: from eggs.gnu.org ([208.118.235.92]:32871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1geJLq-0005A8-Bf
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 07:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1geJLl-0005gf-Dc
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 07:40:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:53532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1geJLl-0005fq-7v
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 07:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1geJLj-0004Or-Cy
	for <qemu-devel@nongnu.org>; Tue, 01 Jan 2019 12:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5460F2E8024
	for <qemu-devel@nongnu.org>; Tue,  1 Jan 2019 12:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Jan 2019 12:32:21 -0000
From: Theo Linkspfeifer <1810105@bugs.launchpad.net>
Reply-To: Bug 1810105 <1810105@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154619733010.25184.13183315891827288064.malonedeb@gac.canonical.com>
Message-Id: <154634594197.26104.5480964685645898942.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810105] Re: Hint showing volume never disappears,
 blocking buttons to minimize, maximize and close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810105

Title:
  Hint showing volume never disappears, blocking buttons to minimize,
  maximize and close

Status in QEMU:
  New
Status in xfce4-pulseaudio-plugin package in Ubuntu:
  New

Bug description:
  When hovering the mouse over the volume indicator or changing its
  volume using the mouse wheel it shows the current volume set as a
  hint. For example:

  Volume 100%

  The problem is that the hint never disappears, not even clicking on
  it. On some occasions the hint can cover the minimize, maximize and
  close buttons, causing significant problems on using the desktop
  environment, as these three buttons won't be usable anymore with the
  hint over it.

  Where the hint appears it's no longer possible to interact with the
  screen.

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: xfce4-pulseaudio-plugin 0.4.1-0ubuntu1
  ProcVersionSignature: Ubuntu 4.15.0-43.46-generic 4.15.18
  Uname: Linux 4.15.0-43-generic x86_64
  ApportVersion: 2.20.9-0ubuntu7.5
  Architecture: amd64
  CurrentDesktop: XFCE
  Date: Sun Dec 30 17:09:23 2018
  InstallationDate: Installed on 2018-12-30 (0 days ago)
  InstallationMedia: Xubuntu 18.04.2 LTS "Bionic Beaver" - Beta amd64 (2018=
1230)
  SourcePackage: xfce4-pulseaudio-plugin
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810105/+subscriptions
