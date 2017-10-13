Received: from eggs.gnu.org ([2001:4830:134:3::10]:34617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vjM-0003mj-3L
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vjL-0000go-Bg
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:08 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 13 Oct 2017 16:53:54 +0800
Message-Id: <20171013085355.7563-3-famz@redhat.com>
In-Reply-To: <20171013085355.7563-1-famz@redhat.com>
References: <20171013085355.7563-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] MAINTAINERS: Fix Sun4v file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 18ddaf4070..3938ccbf8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -778,7 +778,7 @@ F: pc-bios/openbios-sparc64
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
-F: hw/sparc64/sun4v.c
+F: hw/sparc64/niagara.c
 F: hw/timer/sun4v-rtc.c
 F: include/hw/timer/sun4v-rtc.h
 
-- 
2.13.5
