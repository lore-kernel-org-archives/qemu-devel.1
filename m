Received: from eggs.gnu.org ([2001:4830:134:3::10]:55159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCje-0007j1-UA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCjb-0002Qk-TL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:50:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCjb-0002Q5-NW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:50:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCja-0007Vy-Fe
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:50:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D19BB2E80DA
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:50:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:39:20 -0000
From: Thomas Huth <1611979@bugs.launchpad.net>
Reply-To: Bug 1611979 <1611979@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160810223630.29693.49469.malonedeb@gac.canonical.com>
Message-Id: <20170111063920.27094.79995.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1611979] Re: GTK+ interface,
 backspace is broken in the monitor console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1611979

Title:
  GTK+ interface, backspace is broken in the monitor console

Status in QEMU:
  Fix Released

Bug description:
  this has been broken for over 2 years

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1611979/+subscriptions
