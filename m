Received: from eggs.gnu.org ([2001:4830:134:3::10]:38246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cqQuP-0002Xh-Pb
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 17:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cqQuK-0000Ou-QC
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 17:01:37 -0400
Received: from mail.kernel.org ([198.145.29.136]:60196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cqQuK-0000Mx-Js
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 17:01:32 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 21 Mar 2017 14:01:26 -0700
Message-Id: <1490130086-22057-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH] add xen-9p-backend to MAINTAINERS under Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, Stefano Stabellini <stefano@aporeto.com>, groug@kaod.org, anthony.perard@citrix.com

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: groug@kaod.org
CC: anthony.perard@citrix.com
---
This patch is meant to be on top of
http://marc.info/?l=xen-devel&m=149003409510264&w=2
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be79f68..bd5218e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -327,6 +327,7 @@ L: xen-devel@lists.xenproject.org
 S: Supported
 F: xen-*
 F: */xen*
+F: hw/9pfs/xen-9p-backend.c
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
 F: hw/net/xen_nic.c
-- 
1.9.1
