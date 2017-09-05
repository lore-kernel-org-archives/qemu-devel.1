Received: from eggs.gnu.org ([2001:4830:134:3::10]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpI9y-0003v4-9H
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpI9t-0004Vi-EP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:01:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:42046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dpI9t-0004V8-8h
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:01:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dpI9s-0002D3-1Q
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 18:01:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D0FB02E80D3
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 18:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Sep 2017 17:55:46 -0000
From: kallisti5 <1715203@bugs.launchpad.net>
Reply-To: Bug 1715203 <1715203@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715203] [NEW] Maintain Haiku support
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

It was pointed out that the 2.10 release notes are pushing to drop Haiku
support.  The qemu port is currently working as-is under Haiku.

Was there a reason this was recommended? Is there anything Haiku can do
to keep it from being dropped?

We're working on a docker container to cross-compile rust-lang for
Haiku, could this be of some use to qemu when complete?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715203

Title:
  Maintain Haiku support

Status in QEMU:
  New

Bug description:
  It was pointed out that the 2.10 release notes are pushing to drop
  Haiku support.  The qemu port is currently working as-is under Haiku.

  Was there a reason this was recommended? Is there anything Haiku can
  do to keep it from being dropped?

  We're working on a docker container to cross-compile rust-lang for
  Haiku, could this be of some use to qemu when complete?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715203/+subscriptions
