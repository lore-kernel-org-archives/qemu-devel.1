Received: from eggs.gnu.org ([209.51.188.92]:47343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wih-0003tC-9c
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0000Wv-Eu
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wig-0000UC-5l
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id g20so14081951wmh.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:05 +0100
Message-Id: <1552117698-12355-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/25] update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Kiarie <davidkiarie4@gmail.com>

From: David Kiarie <davidkiarie4@gmail.com>

Signed-off-by: David Kiarie <davidkiarie4@gmail.com>
Message-Id: <20190304151827.1813-2-davidkiarie4@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
