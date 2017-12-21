Received: from eggs.gnu.org ([2001:4830:134:3::10]:44582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eS2S0-00082P-Uy
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eS2Rq-000646-Rz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:08:00 -0500
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:57263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eS2Rq-0005rD-HJ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:07:50 -0500
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 91C58B4B3C
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 16:07:37 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 21 Dec 2017 16:07:34 +0100
Message-ID: <151386885405.30639.8211398922585070373.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Drop Aneesh as 9pfs maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Aneesh has been working on other topics for some time now. Let's reflect
that in the MAINTAINERS file, so that people stop Cc'ing him.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 MAINTAINERS |    2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8859a50c365b..a61f3acb84ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1082,13 +1082,11 @@ F: include/hw/virtio/
 F: tests/virtio-balloon-test.c
 
 virtio-9p
-M: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
 M: Greg Kurz <groug@kaod.org>
 S: Supported
 F: hw/9pfs/
 F: fsdev/
 F: tests/virtio-9p-test.c
-T: git git://github.com/kvaneesh/QEMU.git
 T: git git://github.com/gkurz/qemu.git 9p-next
 
 virtio-blk
