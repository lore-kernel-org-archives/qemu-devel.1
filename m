Received: from eggs.gnu.org ([2001:4830:134:3::10]:56900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gx1-0005XW-2v
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwo-0008Az-V6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:34 +1000
Message-Id: <20170426070034.10727-49-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 48/48] MAINTAINERS: Remove myself from e500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Scott Wood <oss@buserror.net>, David Gibson <david@gibson.dropbear.id.au>

From: Scott Wood <oss@buserror.net>

I recently left Freescale/NXP, and even before that it'd been a few years
since I was actively involved in KVM/QEMU work.

Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cae3b09..6bd5097 100644
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
2.9.3
