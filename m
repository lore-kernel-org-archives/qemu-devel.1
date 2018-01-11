Received: from eggs.gnu.org ([2001:4830:134:3::10]:53011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eZdjh-00012n-5x
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eZdjc-0003N8-Ai
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:21:41 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Thu, 11 Jan 2018 17:21:25 +0300
Message-Id: <20180111142125.17034-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH trivial] qapi-schema.json: spelling
 (independant comparation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
