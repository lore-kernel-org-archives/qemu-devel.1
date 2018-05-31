Received: from eggs.gnu.org ([2001:4830:134:3::10]:36314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOTZ7-0000Ky-9Z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOTZ3-0003kj-D0
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:48:53 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOTZ3-0003k5-6T
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:48:49 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:48:43 +0200
Message-Id: <20180531194843.21172-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] slirp: Add Samuel Thibault's staging tree for
 slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, jan.kiszka@siemens.com

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41cd3736a9..8822ae9b70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1675,6 +1675,7 @@ S: Maintained
 F: slirp/
 F: net/slirp.c
 F: include/net/slirp.h
+T: git http://people.debian.org/~sthibault/qemu.git slirp
 T: git git://git.kiszka.org/qemu.git queues/slirp
 
 Stubs
-- 
2.17.0
