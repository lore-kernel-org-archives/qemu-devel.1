Received: from eggs.gnu.org ([2001:4830:134:3::10]:51922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDw-0006fB-7Y
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDt-0006QL-4u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:38 +0300
Message-Id: <626e4a4b69d7f3952b526a5d0aa8a4a040a7cd52.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 11/14] MAINTAINERS: Fix Sun4v file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Fam Zheng <famz@redhat.com>

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86c9ec9cde..6ce393f50d 100644
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
2.11.0
