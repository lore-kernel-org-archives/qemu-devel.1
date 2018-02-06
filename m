Received: from eggs.gnu.org ([2001:4830:134:3::10]:44787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tz-0000wq-5K
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tw-0003Bz-9h
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:39 -0500
Received: from mail-eopbgr00109.outbound.protection.outlook.com
	([40.107.0.109]:52480
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9tv-00039t-W9
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:36 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:30 +0300
Message-Id: <20180206203048.11096-17-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 16/34] hyperv: update copyright notices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h     | 1 +
 hw/misc/hyperv_testdev.c | 1 +
 target/i386/hyperv.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index fcc41caf1f..8b7fcd0b48 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -2,6 +2,7 @@
  * QEMU KVM Hyper-V support
  *
  * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
  *
  * Authors:
  *  Andrey Smetanin <asmetanin@virtuozzo.com>
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 79077789e1..b9e1f1cc74 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -2,6 +2,7 @@
  * QEMU KVM Hyper-V test device to support Hyper-V kvm-unit-tests
  *
  * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
  *
  * Authors:
  *  Andrey Smetanin <asmetanin@virtuozzo.com>
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 3dc8a7acb0..e43cbb9322 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -2,6 +2,7 @@
  * QEMU KVM Hyper-V support
  *
  * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
  *
  * Authors:
  *  Andrey Smetanin <asmetanin@virtuozzo.com>
-- 
2.14.3
