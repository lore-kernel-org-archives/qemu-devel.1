Received: from eggs.gnu.org ([2001:4830:134:3::10]:44294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6T-0001cv-Vu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6T-0003j0-6U
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:41 -0500
Received: from mail.kernel.org ([198.145.29.136]:51210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6S-0003f5-QP
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:41 -0500
Date: Thu, 2 Mar 2017 08:20:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-8-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] MAINTAINERS: Add VM Generation ID entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>

From: Ben Warren <ben@skyportsystems.com>

Signed-off-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b54935..b9a2171 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1124,6 +1124,15 @@ F: hw/nvram/chrp_nvram.c
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
MST
