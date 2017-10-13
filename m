Received: from eggs.gnu.org ([2001:4830:134:3::10]:44657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2oik-0004TU-8M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 21:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2oii-00011X-TG
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 21:25:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 13 Oct 2017 09:24:54 +0800
Message-Id: <20171013012455.10737-2-famz@redhat.com>
In-Reply-To: <20171013012455.10737-1-famz@redhat.com>
References: <20171013012455.10737-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] MAINTAINERS: Fix scsi path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 772ac209e1..da3c78df47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -982,7 +982,7 @@ S: Supported
 F: include/hw/scsi/*
 F: include/scsi/*
 F: hw/scsi/*
-F: util/scsi*
+F: scsi/*
 F: tests/virtio-scsi-test.c
 T: git git://github.com/bonzini/qemu.git scsi-next
 
-- 
2.13.5
