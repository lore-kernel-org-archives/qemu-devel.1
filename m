Received: from eggs.gnu.org ([2001:4830:134:3::10]:33415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df3fd-0005pM-Et
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df3fY-0002UE-EV
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:31:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:33869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1df3fY-0002Tn-8t
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:31:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1df3fV-0004Ki-0m
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 12:31:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 82D0E2E80D3
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 12:31:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 12:16:10 -0000
From: Stefan Hajnoczi <1708462@bugs.launchpad.net>
Reply-To: Bug 1708462 <1708462@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150176961654.13001.1653024142886908093.malonedeb@soybean.canonical.com>
Message-Id: <150219457035.17031.2930727750473564981.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1708462] Re: Support Python 3 to build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Python 2 EOL is in 2020 so there is a fair amount of time.

QEMU is transitioning to support both Python 2.6+ and 3 but most Python
code has not been converted yet.

You are welcome to contribute patches:
https://wiki.qemu.org/index.php/Contribute/SubmitAPatch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708462

Title:
  Support Python 3 to build

Status in QEMU:
  New

Bug description:
  Currently qemu's configure requires Python 2 to build.  As Python 2 is
  rapidly approaching its EOL, it should be possible to build qemu with
  Python 3.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708462/+subscriptions
