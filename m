Received: from eggs.gnu.org ([2001:4830:134:3::10]:47745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dvz73-0002IQ-Ln
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 01:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dvz70-0003pk-DC
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 01:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:38230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dvz70-0003pG-6q
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 01:05:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dvyc8-0005te-MR
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 04:33:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C995F2E84C2
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 04:33:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Sep 2017 04:17:25 -0000
From: Launchpad Bug Tracker <1181354@bugs.launchpad.net>
Reply-To: Bug 1181354 <1181354@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130517183729.15720.99670.malonedeb@chaenomeles.canonical.com>
Message-Id: <150622664520.19123.6354493167989073976.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1181354] Re: assert failed in scsi-bus.c line
 1539 in SCSI_XFER_NONE
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
https://bugs.launchpad.net/bugs/1181354

Title:
  assert failed in scsi-bus.c line 1539 in SCSI_XFER_NONE

Status in QEMU:
  Expired

Bug description:
  Every time I format a SCSI hard disk (on ID 0) with Windows NT or DOS,
  QEMU crashes with an assertion failure on scsi-bus.c, any help?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1181354/+subscriptions
