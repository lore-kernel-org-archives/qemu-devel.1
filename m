Received: from eggs.gnu.org ([209.51.188.92]:53802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gxUxe-0001xx-JY
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gxUxd-0006QF-Q4
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:55:14 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1gxUxd-0006PG-HY
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:55:13 -0500
Received: by mail-wm1-x341.google.com with SMTP id x7so4084442wmj.0
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 02:55:13 -0800 (PST)
From: David Kiarie <davidkiarie4@gmail.com>
Date: Sat, 23 Feb 2019 13:54:21 +0300
Message-Id: <20190223105421.1290-2-davidkiarie4@gmail.com>
In-Reply-To: <20190223105421.1290-1-davidkiarie4@gmail.com>
References: <20190223105421.1290-1-davidkiarie4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] hw/i386: update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, alexaltea123@gmail.com, peterx@redhat.com, jan.kiszka@siemens.com, David Kiarie <davidkiarie4@gmail.com>

Signed-off-by: David Kiarie <davidkiarie4@gmail.com>
---
 hw/i386/amd_iommu.c | 2 +-
 hw/i386/amd_iommu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8ad707a..4f179da 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2,7 +2,7 @@
  * QEMU emulation of AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
+ * Copyright (C) 2016 David Kiarie Kahurani
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c52886f..cb258a7 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -2,7 +2,7 @@
  * QEMU emulation of an AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
+ * Copyright (C) 2016 David Kiarie Kahurani
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
2.20.1
