Received: from eggs.gnu.org ([2001:4830:134:3::10]:58452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewTVl-00022d-16
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewTVf-00015i-6f
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:52196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewTVf-000152-07
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:05:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewTVd-0008QX-SN
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:05:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CA0572E80C0
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:05:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 13:55:51 -0000
From: "barry.of.smith@gmail.com" <barry.of.smith@googlemail.com>
Reply-To: Bug 1756080 <1756080@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152112215198.15095.6439554295431781559.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756080] [NEW] QEMU does not provide non-Linux
 kernels with ATAGS structure on ARM targets
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

This would be a useful feature. Many kernels, particularly hobbyist
kernels, have support for ATAGS.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756080

Title:
  QEMU does not provide non-Linux kernels with ATAGS structure on ARM
  targets

Status in QEMU:
  New

Bug description:
  This would be a useful feature. Many kernels, particularly hobbyist
  kernels, have support for ATAGS.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756080/+subscriptions
