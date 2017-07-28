Received: from eggs.gnu.org ([2001:4830:134:3::10]:47565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxx7-000466-34
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxx6-00039c-9m
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:35:32 -0300
Message-Id: <20170728053610.15770-10-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/47] MAINTAINERS: add missing entry for
 virtio/9p
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6da3264d4e..4f9ce6e686 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1056,6 +1056,7 @@ S: Supported
 F: hw/9pfs/
 F: fsdev/
 F: tests/virtio-9p-test.c
+F: include/standard-headers/linux/virtio_9p.h
 T: git git://github.com/kvaneesh/QEMU.git
 T: git git://github.com/gkurz/qemu.git 9p-next
 
-- 
2.13.3
