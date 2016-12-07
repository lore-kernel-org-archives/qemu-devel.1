Received: from eggs.gnu.org ([2001:4830:134:3::10]:52700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEbhF-0004SZ-4n
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEbhC-0004xB-Ce
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:51:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1cEbhC-0004wN-77
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:51:38 -0500
From: Frediano Ziglio <fziglio@redhat.com>
Date: Wed,  7 Dec 2016 12:51:30 +0000
Message-Id: <20161207125130.5184-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH] egl-helpers: Change file licensing to LGPL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Cole Robinson <crobinso@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 ui/egl-helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 79cee05..cd24568 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -1,3 +1,19 @@
+/*
+ * Copyright (C) 2015-2016 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 #include "qemu/osdep.h"
 #include <glob.h>
 #include <dirent.h>
-- 
2.9.3
