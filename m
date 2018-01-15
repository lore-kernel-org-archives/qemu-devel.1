Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eb3Hl-0005nH-U3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eb3Hi-0001SU-Pv
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:50:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:49016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eb3Hi-0001S7-K4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eb3Hh-0003eh-4u
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:50:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 219FC2E8552
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:50:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2018 11:43:41 -0000
From: Daniel Berrange <1708462@bugs.launchpad.net>
Reply-To: Bug 1708462 <1708462@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150176961654.13001.1653024142886908093.malonedeb@soybean.canonical.com>
Message-Id: <151601662108.10253.1792259999696016075.malone@gac.canonical.com>
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

Two patches series posted in Aug last year:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03642.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06528.html

An updated series covering both of those, and also turning on tests

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02978.html

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
