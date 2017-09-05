Received: from eggs.gnu.org ([2001:4830:134:3::10]:38029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpISz-0001m6-KO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpISv-0006EY-0F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:44758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dpISu-0006E8-Q2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:20:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dpISt-0002iT-Io
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 18:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D7E72E80D2
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 18:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Sep 2017 18:14:07 -0000
From: kallisti5 <1715203@bugs.launchpad.net>
Reply-To: Bug 1715203 <1715203@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
Message-Id: <150463524785.11238.8706878766331677095.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715203] Re: Maintain Haiku support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Haiku recently got a virtio driver, so running a Haiku system in cloud
infrastructure seems possible now. (I've personally run it on vultr.com)
Does QEMU have some infrastructure available so we can stand up a x86_64
system?

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
