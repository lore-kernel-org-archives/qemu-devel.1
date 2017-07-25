Received: from eggs.gnu.org ([2001:4830:134:3::10]:34496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZvoJ-00074E-SG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZvoF-0002KJ-EB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:07:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:49931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dZvoF-0002K2-8Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:07:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dZvoE-0001M6-EO
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 09:07:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 666A72E80C7
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 09:07:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jul 2017 08:53:13 -0000
From: Thomas Huth <1181354@bugs.launchpad.net>
Reply-To: Bug 1181354 <1181354@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130517183729.15720.99670.malonedeb@chaenomeles.canonical.com>
Message-Id: <150097279443.26794.8903288947913895388.launchpad@chaenomeles.canonical.com>
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

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1181354

Title:
  assert failed in scsi-bus.c line 1539 in SCSI_XFER_NONE

Status in QEMU:
  Incomplete

Bug description:
  Every time I format a SCSI hard disk (on ID 0) with Windows NT or DOS,
  QEMU crashes with an assertion failure on scsi-bus.c, any help?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1181354/+subscriptions
