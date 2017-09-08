Received: from eggs.gnu.org ([2001:4830:134:3::10]:39110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqNEE-0007Lx-GJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqNEA-0007Vw-Jt
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:38:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  8 Sep 2017 14:36:27 -0300
Message-Id: <20170908173632.6711-9-f4bug@amsat.org>
In-Reply-To: <20170908173632.6711-1-f4bug@amsat.org>
References: <20170908173632.6711-1-f4bug@amsat.org>
In-Reply-To: <20170908173146.6446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/15] MAINTAINERS: add missing entries for
 throttling infra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 517c8f95d7..4e05831bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1574,8 +1574,10 @@ M: Alberto Garcia <berto@igalia.com>
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
2.14.1
