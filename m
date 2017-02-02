Received: from eggs.gnu.org ([2001:4830:134:3::10]:38286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEb-0003qC-5F
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEZ-0004fw-78
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:53 -0500
Received: from mail.kernel.org ([198.145.29.136]:45150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cZMEZ-0004fX-0p
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:51 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu,  2 Feb 2017 10:35:40 -0800
Message-Id: <1486060541-29146-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1486060541-29146-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
	<1486060541-29146-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 4/5] MAINTAINERS: Update xen-devel mailing list
 address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, peter.maydell@linaro.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a428cb2..baea7c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -323,7 +323,7 @@ Guest CPU Cores (Xen):
 X86
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
-L: xen-devel@lists.xensource.com
+L: xen-devel@lists.xenproject.org
 S: Supported
 F: xen-*
 F: */xen*
-- 
1.9.1
