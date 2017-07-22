Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYm8h-0005pH-Ah
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYm8e-0000Ez-4p
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:35:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:38211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYm8d-0000EF-Tc
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:35:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYm8b-0005gI-5n
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 04:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 87AA22E80AD
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 04:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Jul 2017 04:17:30 -0000
From: Launchpad Bug Tracker <1300021@bugs.launchpad.net>
Reply-To: Bug 1300021 <1300021@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140331055853.6092.52126.malonedeb@chaenomeles.canonical.com>
Message-Id: <150069705078.16349.8657541459193371630.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1300021] Re: after loadvm the system clock isn't
 current time
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
https://bugs.launchpad.net/bugs/1300021

Title:
  after loadvm the system clock isn't current time

Status in QEMU:
  Expired

Bug description:
  hi,
  when i load a  snapshot of month ago using "loadvm  name"command, the vm =
system time is past time,not recover current time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1300021/+subscriptions
