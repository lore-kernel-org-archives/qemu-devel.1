Received: from eggs.gnu.org ([2001:4830:134:3::10]:36982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7ZJs-0004E1-8z
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7ZJp-00033S-22
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:48954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f7ZJo-000333-RM
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f7ZJn-0003CV-MD
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 04:31:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95E032E80CB
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 04:31:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Apr 2018 04:17:27 -0000
From: Launchpad Bug Tracker <1402289@bugs.launchpad.net>
Reply-To: Bug 1402289 <1402289@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141213223120.22142.21828.malonedeb@gac.canonical.com>
Message-Id: <152376584762.25258.1981932812496505480.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1402289

Title:
  netware 5.1 and SCSI (LSI Logic 53c895a) =3D lsi_scsi: error: readb 0x49

Status in QEMU:
  Expired

Bug description:
  Subj.

  This error occurs while loading LSIHINW.HAM driver in the netware5.1
  SP8 installer.

  Affected versions: qemu 2.1.2 and 2.2.50 from git (2014-12-14).
  Linux kernel: 3.17.6 and 3.18.0.

  Debug log for machine in the attachment.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1402289/+subscriptions
