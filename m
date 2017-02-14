Received: from eggs.gnu.org ([2001:4830:134:3::10]:55296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlf-0003Tx-8U
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUle-0001P7-4b
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:58067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdUld-0001Oi-Ul
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdUlc-0004PE-Rq
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:31:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BADF52E80CD
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:31:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 04:17:33 -0000
From: Launchpad Bug Tracker <810588@bugs.launchpad.net>
Reply-To: Bug 810588 <810588@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110714164328.4200.70793.malonedeb@wampee.canonical.com>
Message-Id: <20170214041734.28611.12742.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 810588] Re: Unexpected crash of qemu-kvm with
 SCSI disk emulation.
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
https://bugs.launchpad.net/bugs/810588

Title:
  Unexpected crash of qemu-kvm with SCSI disk emulation.

Status in QEMU:
  Expired

Bug description:
  Virual machine with MS windows 2003 installed on the virtual scsi disk (-=
drive file=3D/my/path/myimage.qcow2.img,boot=3Don,if=3Dscsi,media=3Ddisk,bu=
s=3D0,unit=3D1) unexpectedly crashes without core dump. When the image is c=
onnected as an ide disk (-hda )  vm flies normally.
  Qemu-kvm version: 0.12.5
  Os/distr.: Debian squeeze, x86_64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/810588/+subscriptions
