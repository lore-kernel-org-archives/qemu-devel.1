Received: from eggs.gnu.org ([2001:4830:134:3::10]:52282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct5sT-0000Jg-Gp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct5sO-0000tm-Qp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 01:10:37 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 29 Mar 2017 16:09:58 +1100
Message-Id: <20170329050958.3652-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr_pci: Removed unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This leftover is just confusing :)


---
 hw/ppc/spapr_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 097ebdd51d..e7567e2e8f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -50,8 +50,6 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 
-#include "hw/vfio/vfio.h"
-
 /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
 #define RTAS_QUERY_FN           0
 #define RTAS_CHANGE_FN          1
-- 
2.11.0
