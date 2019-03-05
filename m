Received: from eggs.gnu.org ([209.51.188.92]:59263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h1Bpt-0002RG-Lh
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h1Bpr-0004kf-1g
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:18:29 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1h1Bpp-0004hw-PH
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:18:25 -0500
Received: by mail-wm1-x342.google.com with SMTP id q187so2948516wme.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 07:18:24 -0800 (PST)
From: David Kiarie <davidkiarie4@gmail.com>
Date: Tue,  5 Mar 2019 18:17:31 +0300
Message-Id: <20190305151731.31213-2-davidkiarie4@gmail.com>
In-Reply-To: <20190305151731.31213-1-davidkiarie4@gmail.com>
References: <20190305151731.31213-1-davidkiarie4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/i386: update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, jan.kiszka@siemens.com, marcel.apfelbaum@gmail.com, alexaltea123@gmail.com, David Kiarie <davidkiarie4@gmail.com>

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
index c52886f..1074723 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -2,7 +2,7 @@
  * QEMU emulation of an AMD IOMMU (AMD-Vi)
  *
  * Copyright (C) 2011 Eduard - Gabriel Munteanu
- * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
+ * Copyright (C) 2015 David Kiarie Kahurani
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
2.21.0
