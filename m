Received: from eggs.gnu.org ([2001:4830:134:3::10]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006RU-Cd
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0008OI-Cu
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJf-0008NP-7e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:44 +0100
Message-Id: <1483692945-9866-17-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 16/17] wctablet: update file comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

Be more specific which tablet we emulate.
Add spec link.  Fix copyright.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 7263671..97f1996 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -1,7 +1,11 @@
 /*
- * QEMU Wacome serial tablet emulation
+ * QEMU Wacom Penpartner serial tablet emulation
  *
- * Copyright (c) 2008 Lubomir Rintel
+ * some protocol details:
+ *   http://linuxwacom.sourceforge.net/wiki/index.php/Serial_Protocol_IV
+ *
+ * Copyright (c) 2016 Anatoli Huseu1
+ * Copyright (c) 2016 Gerd Hoffmann
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to
-- 
1.8.3.1
