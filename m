Received: from eggs.gnu.org ([2001:4830:134:3::10]:45083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeJ-0007d7-Jd
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeI-0004IV-MM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:23 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:48614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fRAeI-0004Hp-FN
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:22 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  8 Jun 2018 09:13:13 +0300
Message-Id: <20180608061316.4909-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
References: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 2/5] slirp: Add Samuel Thibault's staging tree
 for slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41cd3736a9..4c73c16fee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1675,6 +1675,7 @@ S: Maintained
 F: slirp/
 F: net/slirp.c
 F: include/net/slirp.h
+T: git https://people.debian.org/~sthibault/qemu.git slirp
 T: git git://git.kiszka.org/qemu.git queues/slirp
 
 Stubs
-- 
2.17.1
