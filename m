Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGGsG-0005vd-DI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGGsB-0000W8-E4
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:38:44 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 May 2018 06:38:20 +0200
Message-Id: <1525840700-30635-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add trace-events and
 qemu-option-trace.texi to tracing section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-trivial@nongnu.org

The "trace-events" and "qemu-option-trace.texi" files in the top directory
are currently "unmaintained" according to scripts/get_maintainer.pl. They
obviously belong to the Tracing section, so add an entry for them there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 459e359..e187b1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1656,6 +1656,8 @@ Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: trace/
+F: trace-events
+F: qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: docs/devel/tracing.txt
-- 
1.8.3.1
