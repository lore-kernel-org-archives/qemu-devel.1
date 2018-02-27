Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqj7a-0001Ev-79
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqj7Z-0001Xm-8j
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:32:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Feb 2018 18:32:51 +0100
Message-Id: <20180227173251.17025-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] vfio-ccw: license text should indicate GPL v2
 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

The license text currently specifies "any version" of the GPL. It
is unlikely that GPL v1 was ever intended; change this to the
standard "or any later version" text.

Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 16713f2c52..4e5855741a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -6,8 +6,8 @@
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
  *            Pierre Morel <pmorel@linux.vnet.ibm.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2 or(at
- * your option) any version. See the COPYING file in the top-level
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
 
-- 
2.13.6
