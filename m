Received: from eggs.gnu.org ([2001:4830:134:3::10]:43949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0F-0002eC-VB
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0C-0000eD-09
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:19 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:54:56 +0300
Message-Id: <8ff5b30b38cae61f7709114307b04bab879f3f04.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/17] qapi-schema.json: spelling (independant
 comparation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi-schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745c79..0262b9f20b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2023,7 +2023,7 @@
 #
 # @static: Expand to a static CPU model, a combination of a static base
 #          model name and property delta changes. As the static base model will
-#          never change, the expanded CPU model will be the same, independant of
+#          never change, the expanded CPU model will be the same, independent of
 #          independent of QEMU version, machine type, machine options, and
 #          accelerator options. Therefore, the resulting model can be used by
 #          tooling without having to specify a compatibility machine - e.g. when
@@ -2102,7 +2102,7 @@
 ##
 # @CpuModelCompareResult:
 #
-# An enumeration of CPU model comparation results. The result is usually
+# An enumeration of CPU model comparison results. The result is usually
 # calculated using e.g. CPU features or CPU generations.
 #
 # @incompatible: If model A is incompatible to model B, model A is not
-- 
2.11.0
