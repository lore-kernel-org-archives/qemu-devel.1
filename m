Received: from eggs.gnu.org ([2001:4830:134:3::10]:48753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxy7-00052X-Kt
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxy4-0004Oo-C9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:37:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:35:58 -0300
Message-Id: <20170728053610.15770-36-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 35/47] MAINTAINERS: add missing entries for
 throttling infra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2b008e305..b9a132d964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1584,8 +1584,10 @@ M: Alberto Garcia <berto@igalia.com>
 S: Supported
 F: block/throttle-groups.c
 F: include/block/throttle-groups.h
-F: include/qemu/throttle.h
+F: include/qemu/throttle*.h
 F: util/throttle.c
+F: docs/throttle.txt
+F: tests/test-throttle.c
 L: qemu-block@nongnu.org
 
 UUID
-- 
2.13.3
