Received: from eggs.gnu.org ([2001:4830:134:3::10]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaPM-0005UO-9r
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaPI-0000Yy-68
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:05:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:45515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHaPI-0000YM-0G
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:05:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHaPG-0007V6-Rb
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:05:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C10282E80C7
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:05:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 17:53:14 -0000
From: Thomas Huth <947273@bugs.launchpad.net>
Reply-To: Bug 947273 <947273@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120305164724.22861.21429.malonedeb@gac.canonical.com>
Message-Id: <20161215175314.27637.21548.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 947273] Re: launchpad homepage url is out of date
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As far as I can see, the "home page" link is now set to http://wiki
.qemu-project.org/ - so it seems this has been fixed.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/947273

Title:
  launchpad homepage url is out of date

Status in QEMU:
  Fix Released

Bug description:
  The launchpad "homepage" link to QEMU's homepage is
  http://www.nongnu.org/qemu/, this link immediately redirects one to
  http://qemu.org (then wiki.qemu.org).

  The link should probably be updated to http://qemu.org

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/947273/+subscriptions
