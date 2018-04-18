Received: from eggs.gnu.org ([2001:4830:134:3::10]:41443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f8pcB-0003sU-P6
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f8pc6-0001TI-Rr
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:07:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:60996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f8pc6-0001Sc-Kg
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:07:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f8pc5-0002WW-P1
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 16:07:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B054B2E8055
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 16:07:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Apr 2018 15:48:18 -0000
From: Thomas Huth <1254443@bugs.launchpad.net>
Reply-To: Bug 1254443 <1254443@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131124134929.7635.53966.malonedeb@wampee.canonical.com>
Message-Id: <152406649862.13358.16904089737646540044.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1254443] Re: Periodic mode of LAPIC doesn't fire
 interrupts when using kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254443

Title:
  Periodic mode of LAPIC doesn't fire interrupts when using kvm

Status in QEMU:
  Incomplete

Bug description:
  It works fine when not using kvm and it does also work fine when using
  oneshot mode.

  Tested with qemu 1.6.1 (commit
  62ecc3a0e3c77a4944c92a02dd7fae2ab1f2290d).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1254443/+subscriptions
