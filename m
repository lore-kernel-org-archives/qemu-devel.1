Received: from eggs.gnu.org ([2001:4830:134:3::10]:46311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnnka-0008SS-Vc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnnkX-0002Jx-Fj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:20:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:43909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dnnkX-0002J8-7r
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:20:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dnnkV-0004fM-Cx
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 15:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5FB352E80C0
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Sep 2017 15:12:32 -0000
From: Taylor Holberton <taylorcholberton@gmail.com>
Reply-To: Bug 1714538 <1714538@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150427875291.17031.5249448331290490011.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714538] [NEW] Support for Raspberry Pi 3 Model B
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

The raspberry pi 3 B uses a 64-bit instruction set. It would be useful
if qemu could emulate the boardn

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714538

Title:
  Support for Raspberry Pi 3 Model B

Status in QEMU:
  New

Bug description:
  The raspberry pi 3 B uses a 64-bit instruction set. It would be useful
  if qemu could emulate the boardn

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714538/+subscriptions
