Received: from eggs.gnu.org ([2001:4830:134:3::10]:35572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiT7-0007wz-CF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiT4-0004x5-E4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:27:01 -0400
Received: from mail-eopbgr30107.outbound.protection.outlook.com
	([40.107.3.107]:15136
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiT4-0004wh-2P
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:58 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:24 +0300
Message-Id: <20170621162424.10462-24-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 23/23] hyperv: update copyright notices
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
 target/i386/hyperv.h     | 1 +
 hw/misc/hyperv_testdev.c | 1 +
 target/i386/hyperv.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index f101144..cba6cbf 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -2,6 +2,7 @@
  * QEMU KVM Hyper-V support
  *
  * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ * Copyright (C) 2017 Parallels International GmbH
  *
  * Authors:
  *  Andrey Smetanin <asmetanin@virtuozzo.com>
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 4fc7787..57ee42d 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -2,6 +2,7 @@
  * QEMU KVM Hyper-V test device to support Hyper-V kvm-unit-tests
  *
  * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ * Copyright (C) 2017 Parallels International GmbH
  *
  * Authors:
  *  Andrey Smetanin <asmetanin@virtuozzo.com>
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index f779977..32c64af 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -2,6 +2,7 @@
  * QEMU KVM Hyper-V support
  *
  * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ * Copyright (C) 2017 Parallels International GmbH
  *
  * Authors:
  *  Andrey Smetanin <asmetanin@virtuozzo.com>
-- 
2.9.4
