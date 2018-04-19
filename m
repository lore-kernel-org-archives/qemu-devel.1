Received: from eggs.gnu.org ([2001:4830:134:3::10]:60851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f919T-0001Zf-SB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 00:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f919Q-0003q5-Oy
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 00:26:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:54526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f919Q-0003od-Gx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 00:26:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f919K-0004w9-Vf
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:26:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 75C552E83E0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:26:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Apr 2018 04:17:17 -0000
From: Launchpad Bug Tracker <1708077@bugs.launchpad.net>
Reply-To: Bug 1708077 <1708077@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150164661181.4282.2707875481070681143.malonedeb@gac.canonical.com>
Message-Id: <152411143968.8799.9819809690014511005.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1708077=5D_Re=3A_PPC_interrupt_exce?=
 =?utf-8?b?cHRpb27vvIE=?=
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
https://bugs.launchpad.net/bugs/1708077

Title:
  PPC interrupt exception=EF=BC=81

Status in QEMU:
  Expired

Bug description:
  There is a exception on interrupt system when run the system with
  debug app on qemu-system-ppc.exe=E3=80=82I have try in version SHA-1:
  2421f381dc38a8a6d12477c08c2f74a35a0698f8 no problem=EF=BC=8Cbut the next
  version SHA-1: 28f997a82cb509bf4775d4006b368e1bde8b7bdd have this
  exception=E3=80=82 And I found during this period in the repair of multi-
  threaded mutex=EF=BC=8Cso I guess whether the PPC has some mutex needed a=
re
  not taken into account=E3=80=82My english is poor=EF=BC=8Cso there may be=
 many
  grammatical errors=E3=80=82I hope you can understand the problem I descri=
bed=E3=80=82

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708077/+subscriptions
