Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2oil-0004Ut-JK
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 21:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2oik-000141-Og
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 21:25:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 13 Oct 2017 09:24:55 +0800
Message-Id: <20171013012455.10737-3-famz@redhat.com>
In-Reply-To: <20171013012455.10737-1-famz@redhat.com>
References: <20171013012455.10737-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] MAINTAINERS: Drop Sun4v nonexistent file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index da3c78df47..731c5c7ec2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -778,7 +778,6 @@ F: pc-bios/openbios-sparc64
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
-F: hw/sparc64/sun4v.c
 F: hw/timer/sun4v-rtc.c
 F: include/hw/timer/sun4v-rtc.h
 
-- 
2.13.5
