Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJsvc-0006aT-It
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJsvX-00039C-Kj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:20:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:41262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eJsvX-00037n-EM
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:20:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eJsvS-0006qv-Qq
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 03:20:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A6BB42E80D7
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 03:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2017 03:10:43 -0000
From: Timothy Pearson <kb9vqf@pearsoncomputing.net>
Reply-To: Bug 1735049 <1735049@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151192504398.10243.14437635177032457733.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735049] [NEW] Need MTTCG support for x86 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

MTTCG support is notably absent for x86_64 guests.  The last Wiki update
on MTTCG was back in 2015, and I am having some difficulty determining
the current status of the underlying requirements to enable this feature
on x86 hosts.

For instance, has support for strong-on-weak memory consistency been
added into QEMU GIT at this point?

Thanks!

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735049

Title:
  Need MTTCG support for x86 guests

Status in QEMU:
  New

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
