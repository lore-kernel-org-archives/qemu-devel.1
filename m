Received: from eggs.gnu.org ([2001:4830:134:3::10]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S2-6F
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDv-0004rp-Bl
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDv-0004rS-68
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDt-0002T7-J2
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95B222E80DE
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:51 -0000
From: Launchpad Bug Tracker <1102027@bugs.launchpad.net>
Reply-To: Bug 1102027 <1102027@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130120115433.12489.5115.malonedeb@soybean.canonical.com>
Message-Id: <20170104041751.27545.37342.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1102027] Re: QED Time travel
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
https://bugs.launchpad.net/bugs/1102027

Title:
  QED Time travel

Status in QEMU:
  Expired

Bug description:
  This night after a reboot of a VM, it was back to 8 Oct. 2012, i've
  lost all data between 8 Oct 2012 and now. I've check the QED file and
  mount on another VM, all seems OK.

  This QED has a raw backfile with the base OS (debian) shared with many
  others QED. It has NO snapshot.

  QEMU emulator version 1.1.2

  Does anyone have a hint ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1102027/+subscriptions
