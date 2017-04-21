Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oss@buserror.net>) id 1d1Nx7-0004h8-MP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oss@buserror.net>) id 1d1Nx4-0000b0-D5
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:05:41 -0400
From: Scott Wood <oss@buserror.net>
Date: Thu, 20 Apr 2017 21:05:28 -0500
Message-Id: <20170421020528.1087-1-oss@buserror.net>
Subject: [Qemu-devel] [RESEND PATCH] MAINTAINERS: Remove myself from e500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Scott Wood <oss@buserror.net>

I recently left Freescale/NXP, and even before that it'd been a few years
since I was actively involved in KVM/QEMU work.

Signed-off-by: Scott Wood <oss@buserror.net>
---
Sorry for the resend -- fixed mailing list address.

 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c60235eaf6..dcb9be1c6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -645,7 +645,6 @@ F: hw/ppc/ppc440_bamboo.c
 
 e500
 M: Alexander Graf <agraf@suse.de>
-M: Scott Wood <scottwood@freescale.com>
 L: qemu-ppc@nongnu.org
 S: Supported
 F: hw/ppc/e500.[hc]
@@ -656,7 +655,6 @@ F: pc-bios/u-boot.e500
 
 mpc8544ds
 M: Alexander Graf <agraf@suse.de>
-M: Scott Wood <scottwood@freescale.com>
 L: qemu-ppc@nongnu.org
 S: Supported
 F: hw/ppc/mpc8544ds.c
@@ -933,7 +931,6 @@ F: include/hw/ppc/ppc4xx.h
 
 ppce500
 M: Alexander Graf <agraf@suse.de>
-M: Scott Wood <scottwood@freescale.com>
 L: qemu-ppc@nongnu.org
 S: Supported
 F: hw/ppc/e500*
-- 
2.11.0
