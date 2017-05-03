Received: from eggs.gnu.org ([2001:4830:134:3::10]:54933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5rYI-0005hW-8C
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5rYH-0003xR-C8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:30:34 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 12:30:23 +0200
Message-Id: <20170503103023.9247-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Update paths for AioContext
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org, famz@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46cf4870f9..62d62a6675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1177,8 +1177,8 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Fam Zheng <famz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
-F: async.c
-F: aio-*.c
+F: util/async.c
+F: util/aio-*.c
 F: block/io.c
 F: migration/block*
 F: include/block/aio.h
-- 
2.12.2
