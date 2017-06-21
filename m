Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiT1-0007se-MY
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSz-0004uU-3g
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:55 -0400
Received: from mail-eopbgr30136.outbound.protection.outlook.com
	([40.107.3.136]:46269
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiSy-0004tv-OG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:53 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:23 +0300
Message-Id: <20170621162424.10462-23-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 22/23] MAINTAINERS: add myself and
 eyakovlev@ for hyperv*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

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
