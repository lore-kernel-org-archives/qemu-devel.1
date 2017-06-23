Received: from eggs.gnu.org ([2001:4830:134:3::10]:55588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORBL-0003Kf-Dc
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORBK-0002bx-KC
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:11:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 23 Jun 2017 13:11:21 -0300
Message-Id: <20170623161121.8047-3-f4bug@amsat.org>
In-Reply-To: <20170623161121.8047-1-f4bug@amsat.org>
References: <20170623161121.8047-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/2] MAINTAINERS: add entry for
 "Unimplemented" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Also voluntary myself as reviewer

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b7543a54e..6febb4f9ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1160,6 +1160,13 @@ F: docs/specs/vmgenid.txt
 F: tests/vmgenid-test.c
 F: stubs/vmgenid.c
 
+Unimplemented device
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/unimp.h
+F: hw/misc/unimp.c
+
 Subsystems
 ----------
 Audio
-- 
2.13.1
