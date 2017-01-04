Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S6-GD
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDx-0004vI-G0
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDx-0004u7-AW
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDv-0002Sy-MC
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A62B62E80CE
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:48 -0000
From: Launchpad Bug Tracker <441672@bugs.launchpad.net>
Reply-To: Bug 441672 <441672@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20091003195706.32421.28307.malonedeb@gangotri.canonical.com>
Message-Id: <20170104041749.27545.43951.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 441672] Re: Windos XP BSOD with HP Photosmart usb
 device attached
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
https://bugs.launchpad.net/bugs/441672

Title:
  Windos XP BSOD with HP Photosmart usb device attached

Status in QEMU:
  Expired

Bug description:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D524723 has all the details
  of the problem.

  I was just testing attaching a USB device to see if it really worked, and=
 tried my HP Photosmart C5580 All-in-One
  printer/scanner, and the Windows XP box then started getting bluescreens =
and crashing at random
  (fairly short :-) intervals.

  My latest attempt was on a fedora rawhide system with pretty up to date s=
oftware
  (qemu-kvm-0.11.0-2.fc12.x86_64), and the crashes still happen.

  A reply to that bugzilla recommended adding this upstream bug, so here
  it is.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/441672/+subscriptions
