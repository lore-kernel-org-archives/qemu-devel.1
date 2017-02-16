Received: from eggs.gnu.org ([2001:4830:134:3::10]:43020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceVHE-0000U3-Mu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceVHD-0000yK-Ns
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:15:52 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:35133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceVHD-0000xs-J1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 18:15:51 -0500
Received: by mail-pg0-x232.google.com with SMTP id t188so9835030pgt.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 15:15:51 -0800 (PST)
From: ben@skyportsystems.com
Date: Thu, 16 Feb 2017 15:15:40 -0800
Message-Id: <e35ffaa91eac609e1caa88b91ad6a930516d5451.1487286467.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v8 8/8] MAINTAINERS: Add VM Generation ID
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

Signed-off-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d4baf..8f5dd35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1125,6 +1125,15 @@ F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
 F: tests/prom-env-test.c
 
+VM Generation ID
+M: Ben Warren <ben@skyportsystems.com>
+S: Maintained
+F: hw/acpi/vmgenid.c
+F: include/hw/acpi/vmgenid.h
+F: docs/specs/vmgenid.txt
+F: tests/vmgenid-test.c
+F: stubs/vmgenid.c
+
 Subsystems
 ----------
 Audio
-- 
2.7.4
