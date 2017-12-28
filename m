Received: from eggs.gnu.org ([2001:4830:134:3::10]:58257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpw-0001Fl-7N
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpv-0001jI-AN
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:59428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUPpv-0001iD-4E
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUPpu-0007WE-9Z
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4753B2E8060
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 04:17:25 -0000
From: Launchpad Bug Tracker <1276879@bugs.launchpad.net>
Reply-To: Bug 1276879 <1276879@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140206011459.1483.59437.malonedeb@wampee.canonical.com>
Message-Id: <151443464572.28609.2679931308695461671.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1276879] Re: lots of dma command 10,
 14 not supported
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
https://bugs.launchpad.net/bugs/1276879

Title:
  lots of dma command 10, 14 not supported

Status in QEMU:
  Expired

Bug description:
  Trying to install NeXTSTEP 3.3 onto a 2GB file with QEMU 1.7.0.
  In the terminal that started QEMU, there are a lot of
      dma: command 10 not supported
  and =

      dma: command 14 not supported
  messages.  When the installation of NeXTSTEP gets to
  'preparing disk for nextstep installation', there are a lot
  of messages that ATA command c5 failed and other info.
  The result is a failed installation.

  Is this a bug in QEMU?  Is there a workaround, e.g. by
  disabling DMA altogether?

  thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1276879/+subscriptions
