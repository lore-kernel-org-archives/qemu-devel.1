Received: from eggs.gnu.org ([209.51.188.92]:58463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0pN9-0007zg-RW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0pN9-000786-6M
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:19:19 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1h0pN7-000705-76
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:19:18 -0500
Received: by mail-wr1-x444.google.com with SMTP id r5so5965822wrg.9
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:19:16 -0800 (PST)
From: David Kiarie <davidkiarie4@gmail.com>
Date: Mon,  4 Mar 2019 18:18:27 +0300
Message-Id: <20190304151827.1813-2-davidkiarie4@gmail.com>
In-Reply-To: <20190304151827.1813-1-davidkiarie4@gmail.com>
References: <20190304151827.1813-1-davidkiarie4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, jan.kiszka@siemens.com, peterx@redhat.com, mst@redhat.com, David Kiarie <davidkiarie4@gmail.com>

Signed-off-by: David Kiarie <davidkiarie4@gmail.com>
---
 hw/i386/amd_iommu.c | 2 +-
 hw/i386/amd_iommu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8ad707a..6eabdf9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2,7 +2,7 @@
  * QEMU emulation of AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
+ * Copyright (C) 2015, 2016 David Kiarie Kahurani
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c52886f..0ff9095 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -2,7 +2,7 @@
  * QEMU emulation of an AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
+ * Copyright (C) 2015, 2016 David Kiarie Kahurani
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
2.21.0
