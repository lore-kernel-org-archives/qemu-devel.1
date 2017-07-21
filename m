Received: from eggs.gnu.org ([2001:4830:134:3::10]:37251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYTag-0000nV-33
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYTab-0004fm-Rf
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:47:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:58368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYTab-0004eT-L8
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:47:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYTaa-0005W4-Nc
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:47:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AFF792E8079
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:47:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 08:33:38 -0000
From: Thomas Huth <533613@bugs.launchpad.net>
Reply-To: Bug 533613 <533613@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100307023408.31337.14368.malonedeb@soybean.canonical.com>
Message-Id: <150062601836.24500.4063918731808521272.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 533613] Re: fr-ca keymap is wrong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch has finally been included here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Db02cf99b9d998b3ec23dae8

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/533613

Title:
  fr-ca keymap is wrong

Status in QEMU:
  Fix Committed

Bug description:
  The fr-ca keymap has tons of wrong keys in it, it affects other projects =
using Qemu/KVM like Xen.
  Documentation about how to make a keymap is too vague to allow me to make=
 something useful to send a patch, I was however able to make something whi=
ch at least allows me to use important keys like dot and slash, I will atta=
ch it for reference.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/533613/+subscriptions
