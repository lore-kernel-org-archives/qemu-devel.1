Received: from eggs.gnu.org ([2001:4830:134:3::10]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAl-0007Wl-VT
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwV-0003se-IN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:40 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:35 +0100
Message-Id: <20181113165247.4806-2-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/13] target: arm: Add copyright boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
---
 target/arm/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0da1424f72..3d4e9c5c8a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,3 +1,10 @@
+/*
+ * ARM generic helpers.
+ *
+ * This code is licensed under the GNU GPL v2.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #include "qemu/osdep.h"
 #include "target/arm/idau.h"
 #include "trace.h"
-- 
2.19.1
