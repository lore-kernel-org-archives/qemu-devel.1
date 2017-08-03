Received: from eggs.gnu.org ([2001:4830:134:3::10]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddH4y-0001ZY-Lu
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddH4v-0001Pe-KJ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:26:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:34875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddH4v-0001OO-EU
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:26:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddH4s-0002Ne-ND
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 14:26:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B1EA2E81BA
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 14:26:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2017 14:13:36 -0000
From: Ross Burton <ross@burtonini.com>
Reply-To: Bug 1708462 <1708462@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150176961654.13001.1653024142886908093.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1708462] [NEW] Support Python 3 to build
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

Currently qemu's configure requires Python 2 to build.  As Python 2 is
rapidly approaching its EOL, it should be possible to build qemu with
Python 3.

** Affects: qemu
     Importance: Undecided
         Status: New

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
