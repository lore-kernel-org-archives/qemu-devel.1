Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dn9iN-000457-I6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dn9iM-0004EC-BZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:36191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dn9iM-0004Dz-62
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dn9iL-0003ke-3z
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:35:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1EE42E807B
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Aug 2017 20:17:32 -0000
From: Thomas Huth <533613@bugs.launchpad.net>
Reply-To: Bug 533613 <533613@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100307023408.31337.14368.malonedeb@soybean.canonical.com>
Message-Id: <150412425346.17031.12063176750391615636.launchpad@gac.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/533613

Title:
  fr-ca keymap is wrong

Status in QEMU:
  Fix Released

Bug description:
  The fr-ca keymap has tons of wrong keys in it, it affects other projects =
using Qemu/KVM like Xen.
  Documentation about how to make a keymap is too vague to allow me to make=
 something useful to send a patch, I was however able to make something whi=
ch at least allows me to use important keys like dot and slash, I will atta=
ch it for reference.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/533613/+subscriptions
