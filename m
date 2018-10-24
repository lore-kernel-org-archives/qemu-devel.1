Received: from eggs.gnu.org ([2001:4830:134:3::10]:35099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFOYI-0000ek-P2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFOYD-0007B5-Rl
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:54646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFOYD-0007A3-Kk
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:10:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFOYC-0005gz-6F
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 19:10:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 25AA62E8030
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 19:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Oct 2018 18:55:52 -0000
From: =?utf-8?b?SGlib3U1N8KgKFlhbm5pY2vCoER1Y2jDqm5lKQ==?=
	<yannick_duchene@yahoo.fr>
Reply-To: Bug 1799768 <1799768@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154040735225.13629.1923075331608721611.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1799768] [NEW] -nodefaults has unclear
 documentation
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

-nodefaults has an unclear documentation, I believe it should states it
does not applies to devices created by a machine model.

See https://stackoverflow.com/questions/52908614/qemu-s-nodefaults-not-
working-as-expected-to-me to read how I came to this.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1799768

Title:
  -nodefaults has unclear documentation

Status in QEMU:
  New

Bug description:
  -nodefaults has an unclear documentation, I believe it should states
  it does not applies to devices created by a machine model.

  See https://stackoverflow.com/questions/52908614/qemu-s-nodefaults-
  not-working-as-expected-to-me to read how I came to this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1799768/+subscriptions
