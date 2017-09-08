Received: from eggs.gnu.org ([2001:4830:134:3::10]:39246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqNEO-0007Y5-6w
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqNEK-0007cF-Rg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:38:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  8 Sep 2017 14:36:31 -0300
Message-Id: <20170908173632.6711-13-f4bug@amsat.org>
In-Reply-To: <20170908173632.6711-1-f4bug@amsat.org>
References: <20170908173632.6711-1-f4bug@amsat.org>
In-Reply-To: <20170908173146.6446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 14/15] MAINTAINERS: update docs/devel/
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

moved in commit ac06724a7158

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53891bd36e..f8630561de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1419,7 +1419,7 @@ F: tests/test-qapi-*.c
 F: tests/test-qmp-*.c
 F: tests/test-visitor-serialization.c
 F: scripts/qapi*
-F: docs/qapi*
+F: docs/devel/qapi*
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
 QAPI Schema
@@ -1471,7 +1471,7 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qmp.c
 F: monitor.c
-F: docs/*qmp-*
+F: docs/devel/*qmp-*
 F: scripts/qmp/
 F: tests/qmp-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
@@ -1502,7 +1502,7 @@ S: Maintained
 F: trace/
 F: scripts/tracetool.py
 F: scripts/tracetool/
-F: docs/tracing.txt
+F: docs/devel/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
 
 TPM
@@ -1525,7 +1525,7 @@ F: include/migration/
 F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
-F: docs/migration.txt
+F: docs/devel/migration.txt
 F: qapi/migration.json
 
 Seccomp
@@ -1923,5 +1923,5 @@ Documentation
 Build system architecture
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
-F: docs/build-system.txt
+F: docs/devel/build-system.txt
 
-- 
2.14.1
