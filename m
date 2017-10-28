Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8ReF-0000wD-FS
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8ReC-0007ym-EF
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:59:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:56312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8ReC-0007xO-7x
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:59:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8ReB-00079k-28
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:59:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F26602E8060
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:59:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:49:02 -0000
From: Thomas Huth <1276879@bugs.launchpad.net>
Reply-To: Bug 1276879 <1276879@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140206011459.1483.59437.malonedeb@wampee.canonical.com>
Message-Id: <150919854229.20175.10287845439601573321.malone@soybean.canonical.com>
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

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1276879

Title:
  lots of dma command 10, 14 not supported

Status in QEMU:
  Incomplete

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
