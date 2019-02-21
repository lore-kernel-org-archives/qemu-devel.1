Received: from eggs.gnu.org ([209.51.188.92]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gwqgP-0007a5-RN
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gwqgP-0005ox-26
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:54:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1gwqgO-0005oA-SR
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:54:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id f14so31268028wrg.1
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:54:44 -0800 (PST)
From: David Kiarie <davidkiarie4@gmail.com>
Date: Thu, 21 Feb 2019 18:53:59 +0300
Message-Id: <20190221155359.8247-2-davidkiarie4@gmail.com>
In-Reply-To: <20190221155359.8247-1-davidkiarie4@gmail.com>
References: <20190221155359.8247-1-davidkiarie4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] hw/i386: snip my name and email
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jan.kiszka@siemens.com, peterx@redhat.com, mst@redhat.com, alexaltea123@gmail.com, David Kiarie <davidkiarie4@gmail.com>

---
 hw/i386/amd_iommu.c | 1 -
 hw/i386/amd_iommu.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8ad707a..e4f3e9c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2,7 +2,6 @@
  * QEMU emulation of AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c52886f..7d577d0 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -2,7 +2,6 @@
  * QEMU emulation of an AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
2.20.1
