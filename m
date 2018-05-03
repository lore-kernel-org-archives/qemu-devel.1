Received: from eggs.gnu.org ([2001:4830:134:3::10]:57343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGJ-000304-Kd
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGG-0002ye-L0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGG-0002yI-G5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:28 -0400
Date: Thu, 3 May 2018 22:51:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-47-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 46/67] cpu-qom: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/target/alpha/cpu-qom.h      | 1 +
 include/target/arm/cpu-qom.h        | 1 +
 include/target/cris/cpu-qom.h       | 1 +
 include/target/hppa/cpu-qom.h       | 1 +
 include/target/i386/cpu-qom.h       | 1 +
 include/target/lm32/cpu-qom.h       | 1 +
 include/target/m68k/cpu-qom.h       | 1 +
 include/target/microblaze/cpu-qom.h | 1 +
 include/target/mips/cpu-qom.h       | 1 +
 include/target/ppc/cpu-qom.h        | 1 +
 include/target/s390x/cpu-qom.h      | 1 +
 include/target/sh4/cpu-qom.h        | 1 +
 include/target/sparc/cpu-qom.h      | 1 +
 include/target/tricore/cpu-qom.h    | 1 +
 include/target/unicore32/cpu-qom.h  | 1 +
 include/target/xtensa/cpu-qom.h     | 1 +
 16 files changed, 16 insertions(+)
 create mode 100644 include/target/alpha/cpu-qom.h
 create mode 100644 include/target/arm/cpu-qom.h
 create mode 100644 include/target/cris/cpu-qom.h
 create mode 100644 include/target/hppa/cpu-qom.h
 create mode 100644 include/target/i386/cpu-qom.h
 create mode 100644 include/target/lm32/cpu-qom.h
 create mode 100644 include/target/m68k/cpu-qom.h
 create mode 100644 include/target/microblaze/cpu-qom.h
 create mode 100644 include/target/mips/cpu-qom.h
 create mode 100644 include/target/ppc/cpu-qom.h
 create mode 100644 include/target/s390x/cpu-qom.h
 create mode 100644 include/target/sh4/cpu-qom.h
 create mode 100644 include/target/sparc/cpu-qom.h
 create mode 100644 include/target/tricore/cpu-qom.h
 create mode 100644 include/target/unicore32/cpu-qom.h
 create mode 100644 include/target/xtensa/cpu-qom.h

diff --git a/include/target/alpha/cpu-qom.h b/include/target/alpha/cpu-qom.h
new file mode 100644
index 0000000..2bacb91
--- /dev/null
+++ b/include/target/alpha/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/alpha/cpu-qom.h"
diff --git a/include/target/arm/cpu-qom.h b/include/target/arm/cpu-qom.h
new file mode 100644
index 0000000..33ddbcf
--- /dev/null
+++ b/include/target/arm/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/arm/cpu-qom.h"
diff --git a/include/target/cris/cpu-qom.h b/include/target/cris/cpu-qom.h
new file mode 100644
index 0000000..01aaf0c
--- /dev/null
+++ b/include/target/cris/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/cris/cpu-qom.h"
diff --git a/include/target/hppa/cpu-qom.h b/include/target/hppa/cpu-qom.h
new file mode 100644
index 0000000..16af5ae
--- /dev/null
+++ b/include/target/hppa/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/hppa/cpu-qom.h"
diff --git a/include/target/i386/cpu-qom.h b/include/target/i386/cpu-qom.h
new file mode 100644
index 0000000..d319042
--- /dev/null
+++ b/include/target/i386/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/i386/cpu-qom.h"
diff --git a/include/target/lm32/cpu-qom.h b/include/target/lm32/cpu-qom.h
new file mode 100644
index 0000000..d167dd0
--- /dev/null
+++ b/include/target/lm32/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/lm32/cpu-qom.h"
diff --git a/include/target/m68k/cpu-qom.h b/include/target/m68k/cpu-qom.h
new file mode 100644
index 0000000..c1eaf99
--- /dev/null
+++ b/include/target/m68k/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/m68k/cpu-qom.h"
diff --git a/include/target/microblaze/cpu-qom.h b/include/target/microblaze/cpu-qom.h
new file mode 100644
index 0000000..db57306
--- /dev/null
+++ b/include/target/microblaze/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/microblaze/cpu-qom.h"
diff --git a/include/target/mips/cpu-qom.h b/include/target/mips/cpu-qom.h
new file mode 100644
index 0000000..a226860
--- /dev/null
+++ b/include/target/mips/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/mips/cpu-qom.h"
diff --git a/include/target/ppc/cpu-qom.h b/include/target/ppc/cpu-qom.h
new file mode 100644
index 0000000..2e74cde
--- /dev/null
+++ b/include/target/ppc/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/cpu-qom.h"
diff --git a/include/target/s390x/cpu-qom.h b/include/target/s390x/cpu-qom.h
new file mode 100644
index 0000000..8c90a83
--- /dev/null
+++ b/include/target/s390x/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/s390x/cpu-qom.h"
diff --git a/include/target/sh4/cpu-qom.h b/include/target/sh4/cpu-qom.h
new file mode 100644
index 0000000..94a8268
--- /dev/null
+++ b/include/target/sh4/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/sh4/cpu-qom.h"
diff --git a/include/target/sparc/cpu-qom.h b/include/target/sparc/cpu-qom.h
new file mode 100644
index 0000000..2e8af3b
--- /dev/null
+++ b/include/target/sparc/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/sparc/cpu-qom.h"
diff --git a/include/target/tricore/cpu-qom.h b/include/target/tricore/cpu-qom.h
new file mode 100644
index 0000000..2c18b33
--- /dev/null
+++ b/include/target/tricore/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/tricore/cpu-qom.h"
diff --git a/include/target/unicore32/cpu-qom.h b/include/target/unicore32/cpu-qom.h
new file mode 100644
index 0000000..1505771
--- /dev/null
+++ b/include/target/unicore32/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/unicore32/cpu-qom.h"
diff --git a/include/target/xtensa/cpu-qom.h b/include/target/xtensa/cpu-qom.h
new file mode 100644
index 0000000..6a9f790
--- /dev/null
+++ b/include/target/xtensa/cpu-qom.h
@@ -0,0 +1 @@
+#include_next "../target/xtensa/cpu-qom.h"
-- 
MST
