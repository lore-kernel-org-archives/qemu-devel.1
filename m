Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5c-00064Y-Bv
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5Y-0007QG-Bm
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:24 -0400
Received: from mail-eopbgr30118.outbound.protection.outlook.com
	([40.107.3.118]:59885
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5Y-0007Pa-3x
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:20 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:47 +0300
Message-Id: <20170606181948.16238-23-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 22/23] MAINTAINERS: add myself and eyakovlev@
 for hyperv*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 120788d..16c5422 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -852,6 +852,13 @@ F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: include/hw/boards.h
 
+Hyper-V emulation core
+M: Roman Kagan <rkagan@virtuozzo.com>
+M: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
+S: Supported
+F: target/i386/hyperv*
+F: hw/misc/hyperv*
+
 Xtensa Machines
 ---------------
 sim
-- 
2.9.4
