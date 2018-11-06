Received: from eggs.gnu.org ([2001:4830:134:3::10]:39230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJx8Y-0007F8-31
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJx8U-0006sj-RS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:55:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:37884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gJx8U-0006s2-ML
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:54:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gJx8T-0007Dr-5j
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 08:54:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D3422E80D0
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 08:54:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Nov 2018 08:38:52 -0000
From: Thomas Huth <1017793@bugs.launchpad.net>
Reply-To: Bug 1017793 <1017793@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120626033602.30040.2545.malonedeb@gac.canonical.com>
Message-Id: <154149353265.13020.15516264054413221133.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1017793] Re: S3 Trio64V+ support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, seems like nobody got interested in adding S3 emulation to QEMU
within the last 6 years, so this is very unlikely going to happen. Thus
I'm closing this bug ticket now.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1017793

Title:
  S3 Trio64V+ support

Status in QEMU:
  Won't Fix

Bug description:
  Is it possible to add S3 Trio emulation to QEMU at all? Since 0.12.3
  the Cirrus Logic seems no longer working properly (bad font
  render/corrupted video). Also, S3 is a widely supported device on many
  OSes and architectures, which will give more compatibility for QEMU.

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1017793/+subscriptions
