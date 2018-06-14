Received: from eggs.gnu.org ([2001:4830:134:3::10]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTT7J-0004Fd-GX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTT7E-00019w-Hw
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:20:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:52706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTT7E-00019V-Ao
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:20:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTT7C-0004pW-Qz
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 14:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B29D92E8082
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 14:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 14:05:55 -0000
From: Waldemar Kozaczuk <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] [NEW] qemu-img convert on Mac OSX
 creates corrupt images
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

An image created by qemu-img create, then modified by another program is
converted to bad/corrupt image when using convert sub command on Mac
OSX. The same convert works on Linux. The version of qemu-img is 2.12.

** Affects: qemu
     Importance: Undecided
         Status: New

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
