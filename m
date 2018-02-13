Received: from eggs.gnu.org ([2001:4830:134:3::10]:43958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elaeN-0005xV-P8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elaeM-0001fL-NH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:29:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:48448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elaeM-0001fA-HH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:29:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elaeL-00021e-Ma
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 13:29:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 99CF62E80CB
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 13:29:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2018 13:16:35 -0000
From: Thomas Huth <1402289@bugs.launchpad.net>
Reply-To: Bug 1402289 <1402289@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141213223120.22142.21828.malonedeb@gac.canonical.com>
Message-Id: <151852779547.3120.17225975801010413046.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1402289] Re: netware 5.1 and SCSI (LSI Logic
 53c895a) = lsi_scsi: error: readb 0x49
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
https://bugs.launchpad.net/bugs/1402289

Title:
  netware 5.1 and SCSI (LSI Logic 53c895a) =3D lsi_scsi: error: readb 0x49

Status in QEMU:
  Incomplete

Bug description:
  Subj.

  This error occurs while loading LSIHINW.HAM driver in the netware5.1
  SP8 installer.

  Affected versions: qemu 2.1.2 and 2.2.50 from git (2014-12-14).
  Linux kernel: 3.17.6 and 3.18.0.

  Debug log for machine in the attachment.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1402289/+subscriptions
