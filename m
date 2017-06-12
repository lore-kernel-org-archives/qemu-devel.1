Received: from eggs.gnu.org ([2001:4830:134:3::10]:47625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dKOIj-0008Qr-TC
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dKOIg-0001am-Pj
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dKOIg-0001Y1-J9
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:18:30 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Mon, 12 Jun 2017 14:18:20 +0200
Message-Id: <20170612121820.31106-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: seccomp: change email contact for
 Eduardo Otubo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Otubo <otubo@redhat.com>

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
