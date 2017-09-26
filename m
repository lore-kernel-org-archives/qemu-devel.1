Received: from eggs.gnu.org ([2001:4830:134:3::10]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwhWT-0007Rw-2J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwhWO-0006yD-6f
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:31:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:48234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dwhWO-0006xp-0V
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:31:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dwhWL-0007lg-0r
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 04:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5035C2E8490
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 04:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Sep 2017 04:17:18 -0000
From: Launchpad Bug Tracker <1354727@bugs.launchpad.net>
Reply-To: Bug 1354727 <1354727@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140809174131.28398.99617.malonedeb@chaenomeles.canonical.com>
Message-Id: <150639943979.28088.15102936049503460805.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1354727] Re: build error with GCC 4.9
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
https://bugs.launchpad.net/bugs/1354727

Title:
  build error with GCC 4.9

Status in QEMU:
  Expired

Bug description:
  % gcc --version
  gcc (GCC) 4.9.1

  latest development version on git

  xen-hvm.c: In function =E2=80=98xen_hvm_init=E2=80=99:
  xen-hvm.c:1008:41: error: =E2=80=98HVM_PARAM_IOREQ_PFN=E2=80=99 undeclare=
d (first use in this function)
       xc_get_hvm_param(xen_xc, xen_domid, HVM_PARAM_IOREQ_PFN, &ioreq_pfn);

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1354727/+subscriptions
