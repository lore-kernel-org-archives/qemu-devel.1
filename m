Received: from eggs.gnu.org ([2001:4830:134:3::10]:43020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPG-0008El-3q
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPD-0007ZA-Ky
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:50 +0100
Message-Id: <20181211180352.19644-29-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/30] MAINTAINERS: Update email address for Fam
 Zheng
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Fam Zheng <fam@euphon.net>

From: Fam Zheng <famz@redhat.com>

Since I am about to change company, update the email address in
MAINTAINERS to my personal one. Depending on responsibility changes I
may eventually fade out in some of the maintained areas, but that will
be figured out afterward, or maybe I'll use the work email later. For
now, just do a search and replace.

Signed-off-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181121153036.2941-1-famz@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e5c9cf52a..02acc1cc8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1301,7 +1301,7 @@ T: git https://github.com/jasowang/qemu.git net
 
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
-R: Fam Zheng <famz@redhat.com>
+R: Fam Zheng <fam@euphon.net>
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
@@ -1629,7 +1629,7 @@ T: git https://repo.or.cz/qemu/kevin.git block
 
 Block I/O path
 M: Stefan Hajnoczi <stefanha@redhat.com>
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: util/async.c
@@ -1643,7 +1643,7 @@ T: git https://github.com/stefanha/qemu.git block
 
 Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
-R: Fam Zheng <famz@redhat.com>
+R: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: include/scsi/*
@@ -1675,7 +1675,7 @@ F: qapi/transaction.json
 T: git https://repo.or.cz/qemu/armbru.git block-next
 
 Dirty Bitmaps
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
@@ -2051,7 +2051,7 @@ F: tests/test-throttle.c
 L: qemu-block@nongnu.org
 
 UUID
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 S: Supported
 F: util/uuid.c
 F: include/qemu/uuid.h
@@ -2182,7 +2182,7 @@ F: disas/tci.c
 Block drivers
 -------------
 VMDK
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/vmdk.c
@@ -2268,13 +2268,13 @@ F: block/gluster.c
 T: git https://github.com/codyprime/qemu-kvm-jtc.git block
 
 Null Block Driver
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/null.c
 
 NVMe Block Driver
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
@@ -2405,7 +2405,7 @@ Build and test automation
 -------------------------
 Build and test automation
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Fam Zheng <famz@redhat.com>
+M: Fam Zheng <fam@euphon.net>
 R: Philippe Mathieu-Daudé <philmd@redhat.com>
 L: qemu-devel@nongnu.org
 S: Maintained
-- 
2.19.2
