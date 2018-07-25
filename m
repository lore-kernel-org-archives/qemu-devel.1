Received: from eggs.gnu.org ([2001:4830:134:3::10]:57451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fiPyC-0007Yj-60
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fiPy9-00015t-9N
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:01:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:44962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fiPy9-00014M-2M
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:01:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fiPy6-0000TW-VA
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 20:01:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E7DA82E80D1
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 20:01:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jul 2018 19:53:57 -0000
From: John Snow <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <153254843716.2620.9026950401369985099.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I marked https://bugs.launchpad.net/qemu/+bug/1738840 as a duplicate of
this bug, even though that bug was older, this bug has a slightly more
active thread.

I'm still in need of either an APFS capable machine that I can reproduce
on, or another mac dev willing to help a bit, though.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
