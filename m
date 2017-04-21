Received: from eggs.gnu.org ([2001:4830:134:3::10]:35751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1ext-0004KN-Rc
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exs-0002kb-Qk
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:37 -0400
Received: from mail.kernel.org ([198.145.29.136]:43174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exs-0002k9-L5
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:36 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:14:59 -0700
Message-Id: <1492805702-19690-18-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 18/21] add xen-9p-backend to MAINTAINERS under
 Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, groug@kaod.org

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
CC: groug@kaod.org
CC: anthony.perard@citrix.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 779c429..420505e 100644
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
