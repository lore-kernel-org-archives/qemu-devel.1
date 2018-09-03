Received: from eggs.gnu.org ([2001:4830:134:3::10]:57527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwqt1-0005ZA-Fh
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fwqsw-0003gr-Ib
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:35:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fwqsw-0003g7-Bg
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:35:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fwqsv-0002ao-7u
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 15:35:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 238532E80CC
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 15:35:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Sep 2018 15:20:25 -0000
From: Thomas Huth <588693@bugs.launchpad.net>
Reply-To: Bug 588693 <588693@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100602125159.13777.33649.malonedeb@gandwana.canonical.com>
Message-Id: <153598802601.31864.17864561380317686954.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 588693] Re: CD-ROM devices always return a one
 session, one track TOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: In Progress =3D> Incomplete

** Changed in: qemu
     Assignee: Natalia Portillo (claunia) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/588693

Title:
  CD-ROM devices always return a one session, one track TOC

Status in QEMU:
  Incomplete

Bug description:
  CD-ROM devices always return a one session, one track TOC, no matter
  if it is using ioctl's with the host or DMG images (both able of
  having multi track, multi session discs).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/588693/+subscriptions
