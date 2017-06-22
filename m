Received: from eggs.gnu.org ([2001:4830:134:3::10]:46774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dNxYf-0005y1-Bi
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dNxYc-00034b-HA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dNxYc-00034H-Bg
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 04:33:42 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 22 Jun 2017 10:33:36 +0200
Message-Id: <20170622083336.19479-2-otubo@redhat.com>
In-Reply-To: <20170622083336.19479-1-otubo@redhat.com>
References: <20170622083336.19479-1-otubo@redhat.com>
Subject: [Qemu-devel] [PULL 01/01] MAINTAINERS: seccomp: change email
 contact for Eduardo Otubo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 120788d..0d065a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,7 +1490,7 @@ F: tests/vmstate-static-checker-data/
 F: docs/migration.txt
 
 Seccomp
-M: Eduardo Otubo <eduardo.otubo@profitbricks.com>
+M: Eduardo Otubo <otubo@redhat.com>
 S: Supported
 F: qemu-seccomp.c
 F: include/sysemu/seccomp.h
-- 
2.9.4
