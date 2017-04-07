Received: from eggs.gnu.org ([2001:4830:134:3::10]:41566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwU7B-00015E-OM
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwU77-0007os-8A
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:39:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:38361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwU77-0007o5-25
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:39:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwU75-0007bV-S4
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:39:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D22D62E805E
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:39:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:26:56 -0000
From: Thomas Huth <1013888@bugs.launchpad.net>
Reply-To: Bug 1013888 <1013888@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120615224639.22616.95414.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170407132656.12396.125.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1013888] Re: windows xp sp3 setup blank screen on
 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Marking this bug as fixed, according to comment #4 and #5

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1013888

Title:
  windows xp sp3 setup blank screen on boot

Status in QEMU:
  Fix Released

Bug description:
  When attempting to run Windows XP SP3 setup in qemu on a Lubuntu host
  with the following kernel:

  Linux michael-XPS-M1530 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10
  20:39:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

  Qemu does not get past a blank screen after "Setup is inspecting your
  computer's hardware configuration"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1013888/+subscriptions
