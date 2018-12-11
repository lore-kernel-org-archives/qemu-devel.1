Received: from eggs.gnu.org ([2001:4830:134:3::10]:56767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gWoNv-000405-A3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gWoNp-00058W-Lw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:12:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:38900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gWoNn-00057F-QH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:11:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gWoNk-0002Pr-PS
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 20:11:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B8F5B2E80AB
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 20:11:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Dec 2018 19:59:44 -0000
From: "Emilio G. Cota" <1735049@bugs.launchpad.net>
Reply-To: Bug 1735049 <1735049@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151192504398.10243.14437635177032457733.malonedeb@wampee.canonical.com>
Message-Id: <154455838431.28219.3618012122971434758.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735049] Re: Need MTTCG support for x86 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This feature is in QEMU v3.1, which was released today.

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735049

Title:
  Need MTTCG support for x86 guests

Status in QEMU:
  Fix Released

Bug description:
  MTTCG support is notably absent for x86_64 guests.  The last Wiki
  update on MTTCG was back in 2015, and I am having some difficulty
  determining the current status of the underlying requirements to
  enable this feature on x86 hosts.

  For instance, has support for strong-on-weak memory consistency been
  added into QEMU GIT at this point?

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735049/+subscriptions
