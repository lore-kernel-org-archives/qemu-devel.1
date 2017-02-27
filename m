Received: from eggs.gnu.org ([2001:4830:134:3::10]:36877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciQXZ-0006xp-5w
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ciQXV-0004SY-9p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:00:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:35575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ciQXV-0004Qk-3c
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:00:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ciQXS-0000Re-Uc
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 19:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA5632E80C2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 19:00:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Feb 2017 18:50:46 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1668360 <1668360@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170227182615.5807.17368.malonedeb@wampee.canonical.com>
Message-Id: <20170227185046.7080.29677.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1668360] Re: Documentation error :404 not found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the report; the right URL is https://www.linux-
kvm.org/images/1/17/2010-forum-qmp-status-talk.pp.pdf and I have updated
the wiki page.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1668360

Title:
  Documentation error :404 not found

Status in QEMU:
  Fix Released

Bug description:
  In http://wiki.qemu-project.org/Documentation/GettingStartedDevelopers
  the url http://www.linux-kvm.org/wiki/images/1/17/2010-forum-qmp-
  status-talk.pp.pdf displays a 404 NOt found error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1668360/+subscriptions
